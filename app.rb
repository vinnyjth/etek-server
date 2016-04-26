require "sinatra"

configure do
  set :rfpath, "~/rfoutlet/codesend"
end

get "/lights" do
  erb :lights
end

post "/lights" do
  `#{settings.rfpath} #{params[:light_code]}`
end
