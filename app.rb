require 'bundler/setup'
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload 'lib/**/*.rb'

get '/' do
  @recipes = Recipe.all
  erb :index
end

post '/' do
  recipe_name = params["recipe_name"]
  @recipe = Recipe.create({ recipe_name: params.fetch('recipe_name') })
  @recipes = Recipe.all
  erb :index
end
