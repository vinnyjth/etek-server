require "sinatra"

configure do
  set :rfpath, "sudo ~/rfoutlet/codesend"
end

get "/lights" do
  erb :lights
end

post "/lights" do
  code = params[:light_code].to_i
  `#{settings.rfpath} #{code}`
end
