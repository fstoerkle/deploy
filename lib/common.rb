

# Common functions

def log(line)
  open("logs/deploy.log", "a") { puts line }  
end


def deploy(repo_name)
  return unless repo_name == "stoerkle.net"

  log "Trying to deploy #{repo_name}"
  
  repo_dir = "/home/stoerkle/repos"
  recipe_file = File.expand_path File.join(File.dirname(__FILE__), "..", "recipes/#{repo_name}") 

  if File.executable?(recipe_file)
    log "Found deployment recipe for #{repo_name}, executing..."
    log `#{recipe_file} "#{repo_name}" "#{repo_dir}"`
  end
end


# Sinatra setup

if Object.const_defined?('Sinatra')

  set(:method) do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end

  before :method => :post do
    @event_type = env["HTTP_X_GITHUB_EVENT"]
    @payload = JSON.parse(params[:payload])
  end
end

