class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'landmarks/new'
  end

  post '/landmarks' do
    # binding.pry
    landmark = Landmark.create(params["landmark"])
      # (name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    landmark.figure = Figure.find_or_create_by(:name => params["figure_name"])
    landmark.save
    redirect "landmarks/#{landmark.id}"
  end

  get '/landmarks/:id/edit' do
    # binding.pry
    @figures = Figure.all
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  patch '/landmarks/:id' do
    # binding.pry
    landmark = Landmark.find(params[:id])
    landmark.update(params["landmark"])
    # (name: params["name"], year_completed: params["landmark"]["year_completed"], figure_id: params["landmark"]["figure_id"])
    if !params["figure"]["name"].empty?
      @landmark.figure_id = Figure.create(name: params["figure"]["name"]).id
    end
    @landmark.save
    redirect to "landmarks/#{@landmark.id}"
  end

end
