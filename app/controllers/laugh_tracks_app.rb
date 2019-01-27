class LaughTracksApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/comedians' do
    @comedians = Comedian.fetch_comedians(params)
    @specials = Special.specials_for_comedians(@comedians)
    @special_count = @specials.count
    @specials_by_comedian = @specials.count_specials_by_comedian
    @average_age = @comedians.average_age
    @city_list = @comedians.birthplaces
    @average_runtime = @specials.average_runtime
    erb :"comedians/index"
  end

  get '/comedians/new' do
    erb :'comedians/new'
  end

  post '/comedians' do
    Comedian.create(params[:comedian])
    redirect '/comedians'
  end
end
