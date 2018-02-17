require_relative "retriable/config"
require "retriable/version"


module Retriable
	module_function
	
  def config
    @config ||= Config.new
  end

  def attempts(opts = {})
    local_config = opts.empty? ? config : Config.new(config.to_h.merge(opts))

    tries             = local_config.tries
    on                = local_config.on

    begin
	    return yield
	  rescue on
	    retry if (tries -= 1) > 0
	  end

	  yield
  end

end
