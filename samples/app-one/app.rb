# frozen_string_literal: true
require "sinatra"

configure do
  set :bind, "0.0.0.0"
  set :port, 4567
end

get "/" do
  "Hello world! This is app 1st"
end
