module Paperclip::Storage::S3
  # This code is copied (and modified) from Paperclip.
  # We can't change it to make Rubocop happy.
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def read
    s3_object.get.body.read
  end

  def flush_writes
    @queued_for_write.each do |style, file|
      retries = 0
      begin
        log("saving #{path(style)}")
        write_options = {
          content_type: file.content_type,
          acl: s3_permissions(style)
        }

        # add storage class for this style if defined
        storage_class = s3_storage_class(style)
        write_options[:storage_class] = storage_class if storage_class

        if @s3_server_side_encryption
          write_options[:server_side_encryption] = @s3_server_side_encryption
        end

        style_specific_options = styles[style]

        if style_specific_options
          merge_s3_headers( style_specific_options[:s3_headers], @s3_headers, @s3_metadata) if style_specific_options[:s3_headers]
          @s3_metadata[style_specific_options[:s3_metadata]] if style_specific_options[:s3_metadata]
        end

        write_options[:metadata] = @s3_metadata unless @s3_metadata.empty?
        write_options.merge!(@s3_headers)

        # Paperclip assumes we are uploading a file to S3, so we must provide
        # this workaround which allows us to upload from a stream.
        # The method is otherwise unaltered.
        s3_object(style).put({ body: file }.merge(write_options))
      rescue ::Aws::S3::Errors::NoSuchBucket
        create_bucket
        retry
      rescue ::Aws::S3::Errors::SlowDown
        retries += 1
        if retries <= 5
          sleep((2**retries) * 0.5)
          retry
        else
          raise
        end
      ensure
        file.rewind
      end
    end

    after_flush_writes

    @queued_for_write = {}
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
end

