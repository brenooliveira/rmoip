module Rmoip
  module Commons
    def initialize(&block)
      @params = {}

      instance_eval &block
    end

    def method_missing(method, *args, &block)
      super unless valid_attr.include? method

      if args.size > 0
        @params[method] = args.first.to_s
      else
        @params[method]
      end
    end
  end
end