# HTTP Configuration - https://github.com/bdurand/http_configuration
options = {
  read_timeout: ENV.fetch("HTTP_READ_TIMEOUT", 8),
  open_timeout: ENV.fetch("HTTP_OPEN_TIMEOUT", 1)
}
Net::HTTP::Configuration.set_global(options)
