class OptionsCapture
  def initialize(context)
    @context = context
  end

  def options
    @options.to_h
  end

  def method_missing(name, *arguments, **options, &block)
    @options = options

    if @context.respond_to? name
      @context.public_send(name, *arguments, **options, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_all)
    @context.respond_to_missing?(name, include_all)
  end
end
