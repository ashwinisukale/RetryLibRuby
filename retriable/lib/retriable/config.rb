module Retriable
  class Config
    ATTRIBUTES = [
      :tries,
      :on
    ].freeze

    attr_accessor(*ATTRIBUTES)

    def initialize(opts = {})
      @tries            = 3
      @on               = StandardError
 
      opts.each do |k, v|
        raise ArgumentError, "#{k} is not a valid option" if !ATTRIBUTES.include?(k)
        instance_variable_set(:"@#{k}", v)
      end
    end

    def to_h
      ATTRIBUTES.each_with_object({}) do |key, hash|
        hash[key] = public_send(key)
      end
    end
  end
end
