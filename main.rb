require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'open-uri'

get '/' do
  @name = "Brian"
  erb :home
end

def get_model(q)
  url = "http://www.omdbapi.com/?s=#{URI.escape(q)}&tomatoes=true"
  results = JSON.load(open(url).read)
  results["Search"]
end

get '/search' do
  @query = params[:q]
  @movies = get_model(@query)
  erb :result
end

def get_movie(link)
  url = "http://www.omdbapi.com/?i=#{URI.escape(link)}&tomatoes=true"
  JSON.load(open(url).read)
end

get '/movie/:imdbID' do
  @link = params[:imdbID]
  @movie = get_movie(@link)
  erb :movie
end

