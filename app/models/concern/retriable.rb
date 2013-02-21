module Retriable
  # This will catch any exception and retry twice (three tries total):
  #   with_retries { ... }
  #
  # This will catch any exception and retry four times (five tries total):
  #   with_retries(:limit => 5) { ... }
  #
  # This will catch a specific exception and retry once (two tries total):
  #   with_retries(Some::Error, :limit => 2) { ... }
  def with_retries(message = nil, *args, &block)
    options = args.extract_options!
    exceptions = args

    options[:limit] ||= 3
    message ||= "run command"
    exceptions = [Exception] if exceptions.empty?

    retries = options[:limit] - 1
    begin
      logger.info("    Trying to #{message}.")
      yield
    rescue *exceptions => e
      if retries > 0
        logger.info("      Trying #{retries} more time#{ retries > 1 ? 's' : '' }.")
        retries -= 1
        retry
      else
        logger.info("      Failed after #{options[:limit]} tries, re-raising exception.")
        raise e
      end
    end
  end
end
