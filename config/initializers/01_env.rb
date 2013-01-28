yml_file = Rails.root.join("config", "env.yml")
ENV.update YAML.load_file(yml_file)[Rails.env] if File.exists?(yml_file)
