libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require "sinatra"
require "sinatra/reloader"
require "json"

require "lib/common.rb"

get "/" do
  "Move along."
end

post "/repo=:name" do
  @repo_name = params[:name]
  log "Received '#{@event_type}' event for repo '#{@repo_name}'"

  if @event_type == "push"
    deploy @repo_name
  elsif @event_type == "ping"
    log " > #{@payload['zen']}"
  end

  log ""

  "OK."
end
