require "sinatra"
require "./whenever_writer"

configure do
  set :rfpath, "sudo ~/rfoutlet/codesend"
end

get "/lights" do
  erb :lights
end

post "/lights" do
  code = params[:light_code].to_i
  puts `#{settings.rfpath} #{code}`
end

post "/lights-schedule" do
  command = {
    runner_type: "command",
    runner_command: "#{settings.rfpath} #{params[:light_code].to_i}"
    period: params[:period]
  }
  w = WheneverWriter.build_and_write_file([command])
end
