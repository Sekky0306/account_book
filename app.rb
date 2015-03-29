require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/item.rb'

set :bind, '192.168.33.10'
set :port, 3000

get '/' do
	@items=Item.all
	@total=Item.sum(:price)
	@categories = Category.all
  erb :index	
end

post '/create' do
	Item.create({
		title: params[:title],
		price: params[:price],
		category_id: params[:category]
		})

	redirect '/'
end
get'/edit/:id' do
	@item= Item.find(params[:id])
	erb :edit
end

get '/category/:id' do
	@categories = Category.all
	@category = Category.find(params[:id])
	@items = @category.items
	erb :index
end

patch '/:id' do
	@item = Item.find(params[:id])
	@item.update({
		title: params[:title],
		price: params[:price]
		})
	redirect '/'
end

delete '/:id' do
	@item = Item.find(params[:id])
	@item.destroy
	redirect '/'
end