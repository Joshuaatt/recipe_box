require 'bundler/setup'
require 'pry'
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload 'lib/**/*.rb'

get '/' do
  @recipes = Recipe.all
  erb :index
end

post '/' do
  recipe_name = params["recipe_name"]
  recipe = Recipe.create({:recipe_name => recipe_name})
  redirect '/'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params["id"].to_i)
  @ingredients = @recipe.ingredients
  erb :recipe
end

post '/recipes/:id' do
  recipe = Recipe.find(params["id"].to_i)
  recipe_id = recipe.id()
  new_ingredient = params["ingredient_name"]
  ingredient = Ingredient.create({ ingredient_name: new_ingredient})
  recipe.update({ :ingredient_ids => [ingredient.id()] })
  redirect "/recipes/#{recipe_id}"
end


# post '/' do
#   recipe_name = params["recipe_name"]
#   recipe = Recipe.create({:recipe_name => recipe_name})
#   redirect '/'
# end
#
# get '/recipe/:id' do
#   # @ingredients = Ingredient.all
#   @recipe = Recipe.find(params["id"].to_i)
#   @ingredients = @recipe.ingredients
#   erb :recipe
# end
#
# post '/recipe/:id' do
#   recipe = Recipe.find(params.fetch("id").to_i)
#
#   @ingredients = params["ingredient_name"]
#   new_ingredient = Ingredient.create({:ingredient_name => @ingredients})
#   recipe.ingredients << new_ingredient
#
#   redirect '/recipe/:id'
# end
