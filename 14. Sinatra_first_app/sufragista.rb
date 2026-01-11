require 'sinatra'
require 'yaml/store'

get '/' do
  @titulo = 'Bem vindo ao Sufragista!'
  erb :index
end

Opcoes = {
  'HAM' => 'Hambúrger',
  'PIZ' => 'Pizza',
  'SUS' => 'Sushi',
  'LAM' => 'Lámen',
}

post '/cast' do
  @titulo = 'Obrigado por votar!'
  @voto = params['voto']
  @store = YAML::Store.new 'votos.yml'
  @store.transaction do
    @store['votos'] ||= {}
    @store['votos'][@voto] ||= 0
    @store['votos'][@voto] += 1
  end
  erb :cast
end

get '/results' do
  @titulo = 'Resultado até agora: '
  @store = YAML::Store.new 'votos.yml'
  @votos = @store.transaction { @store['votos'] }
  erb :results
end

