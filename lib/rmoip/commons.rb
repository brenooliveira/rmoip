module Rmoip
  module Commons
    def initialize(&block)
      @params = {}

      instance_eval &block
    end

    def method_missing(method, *args)
      raise NoMethodError, "Method valid_attr must be implemented" if method == :valid_attr
      raise NoMethodError, "Method required_attr must be implemented" if method == :required_attr
      super unless valid_attr.include? method

      if args.size > 0
        if args.first.nil?
          @params[method] = nil
        else
          @params[method] = args.first.to_s
        end
      else
        @params[method]
      end
    end

    def valid?
      required_attr.each do |attr|
        return false if @params[attr].nil?
      end

      true
    end
  end
end