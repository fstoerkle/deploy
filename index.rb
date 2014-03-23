
require "sinatra"
require "sinatra/reloader"
require "json"

def log(line)
  open("deploy.log", "a") { puts line }  
end

set(:method) do |method|
  method = method.to_s.upcase
  condition { request.request_method == method }
end

before :method => :post do
  type = env["HTTP_X_GITHUB_EVENT"]
  payload = JSON.parse(params[:payload])
end

get "/" do
  "Move along."
end

post "/repo=:name" do
  log "Received '#{type}' event for repo '#{params[:name]}'"

  if type == "push"
    log "foo"
  elsif type == "ping"
    log " > #{payload['zen']}"
  end

  log ""

  "OK."
end
