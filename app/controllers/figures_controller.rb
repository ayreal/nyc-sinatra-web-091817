class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    f = Figure.create(params["figure"])

    if !params["title"]["name"].empty?
      t = Title.create(params["title"])
      f.titles << t
    end

    if !params["landmark"]["name"].empty?
      l = Landmark.create(params["landmark"])
      f.landmarks << l
    end

    f.save
    redirect "figures/#{figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["title"]["name"].empty?
      t = Title.create(params["title"])
      @figure.titles << t
    end

    if !params["landmark"]["name"].empty?
      l = Landmark.create(params["landmark"])
      @figure.landmarks << l
    end

    @figure.save
    redirect to "figures/#{@figure.id}"
  end

end
