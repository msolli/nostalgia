# HTTP Configuration - https://github.com/bdurand/http_configuration
options = {
  read_timeout: ENV.fetch("HTTP_READ_TIMEOUT", 8).to_i,
  open_timeout: ENV.fetch("HTTP_OPEN_TIMEOUT", 1).to_i
}
Net::HTTP::Configuration.set_global(options)
