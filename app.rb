require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/item.rb'

set :bind, '192.168.33.10'
set :port, 3000

use Rack::Session::Cookie

get '/' do
	unless session[:user_id]
		redirect '/session/new'	
	end
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

post'/user/create' do
	User.create({
			name: params[:name],
			password: params[:password],
			password_confirmation: params[:password_confirmation] 

			})
	redirect '/'
end

get'/user/new' do
	erb :user_new
end

post '/session/create' do
	user=User.find_by_name params[:name]
		if user && user.authenticate(params[:password])
			session[:user_id]=user.id
		end
	redirect '/'
end

get '/session/new' do
	erb :seccion_new
end
