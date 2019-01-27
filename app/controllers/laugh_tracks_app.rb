class LaughTracksApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/comedians' do
    @comedians = Comedian.fetch_comedians(params)
    @specials = Special.specials_for_comedians(@comedians)
    @average_age = @comedians.average_age
    @city_list = @comedians.birthplaces
    @average_runtime = @specials.average_runtime
    erb :"comedians/index"
  end
end
