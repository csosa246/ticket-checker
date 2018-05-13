module Paperclip::Storage::Filesystem
  # There's no good reason to assume that the content queued for write comes
  # from a file, rather than a stream.  I've left the orginal code commented
  # out here, to make clear what I changed.  The method is otherwise unaltered.
  #
  # This code is copied (and modified) from Paperclip.
  # We can't change it to make Rubocop happy.
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/NumericLiteralPrefix
  def flush_writes
    @queued_for_write.each do |style_name, file|
      FileUtils.mkdir_p(File.dirname(path(style_name)))
      # begin
      # FileUtils.mv(file.path, path(style_name))
      # rescue SystemCallError
      File.open(path(style_name), 'wb') do |new_file|
        while (chunk = file.read(16 * 1024))
          new_file.write(chunk)
        end
      end
      # end
      unless @options[:override_file_permissions] == false
        resolved_chmod = (@options[:override_file_permissions] & ~0111) || (0666 & ~File.umask)
        FileUtils.chmod(resolved_chmod, path(style_name))
      end
      file.rewind
    end

    after_flush_writes # allows attachment to clean up temp files

    @queued_for_write = {}
  end

  def read
    File.open(path, &:read)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Style/NumericLiteralPrefix
end

