module Paperclip
  class KnownContentTypeIO
    def initialize(content_type: , filename: )
      @io = StringIO.new
      @content_type = content_type || raise('TrustedIO requires a content type')
      @original_filename = filename || raise('TrustedIO requires a filename')
    end

    attr_reader :content_type, :original_filename

    def respond_to_missing?(method, *args)
      super || io.respond_to?(method, *args)
    end

    # rubocop:disable Style/MethodMissing
    # We use method missing here for message forwarding to the underlying StringIO,
    # so we never want to use this object's own #method_missing behavior.
    def method_missing(method, *args, &block)
      io.public_send(method, *args, &block)
    end
    # rubocop:enable Style/MethodMissing

    private

    attr_reader :io
  end

  class KnownContentTypeIOAdapter < AbstractAdapter
    delegate :read, :binmode, :close, :closed?, :eof?, :rewind, to: :target
    undef_method :path, :unlink

    def initialize(target, options = {})
      super
      cache_attributes
    end

    attr_writer :content_type, :size
    alias close! close

    def fingerprint
      pos = target.pos
      target.rewind
      @fingerprint ||= Digest::MD5.hexdigest(target.read)
      target.seek(pos)
      @fingerprint
    end

    def binmode?
      false
    end

    private

    attr_reader :target

    def cache_attributes
      @content_type = target.content_type
      @original_filename = target.original_filename
      @size = target.size
    end
  end
end

Paperclip.io_adapters.register Paperclip::KnownContentTypeIOAdapter do |target|
  target.is_a?(Paperclip::KnownContentTypeIO)
end

