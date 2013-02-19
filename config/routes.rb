Agendatech::Application.routes.draw do
  resources :authentications

  devise_for :users

  devise_for :admins
  namespace :admin do 
    root :to => 'admin#index'
    resources :eventos, :only => [:index,:update] do
      member do
        get 'aprovar'
        get 'desaprovar'
        get 'copiar'
        get 'remover' 
      end
    end
    resources :grupos, :only => [:index,:update,:destroy] do 
      member do
        put 'aprovar'
      end
    end
  end

  resources :eventos, :path_names => {:new => 'novo', :edit => 'editar'}
  resources :comentarios
  resources :grupos

  get '/auth/:provider/callback' => 'authentications#create'
  get '/auth/failure' => 'authentications#failure'
  get 'gadgets/:evento/:tipo' => 'gadgets#create', :as => :gadgets
  get 'rss/feed.:format' => 'rss#feed', :as => :feed
  get 'calendario/eventos' => 'calendario#index', :as => :calendario
  get 'calendario/eventos/:estado' => 'calendario#index', :as => :calendario_por_estado
  get 'colaboradores' => 'sobre#colaboradores', :as => :colaboradores
  get 'facebook' => 'sobre#facebook', :as => :facebook  
  get 'mobile/eventos' => 'mobile#eventos', :format  => :json
  get 'mobile/grupos' => 'mobile#grupos', :format  => :json  
  get 'contato' => 'contato#index', :as => :contato
  get 'sobre' => 'sobre#index', :as => :sobre
  get 'calendario' => 'calendario#links', :as => :calendario_link
  get 'eventos/tecnologia/:ano/:id' => 'eventos#show', :as => :evento
  get 'grupos/:nome/:id/eventos' => 'grupos#show', :as => :grupo
  get 'busca/eventos/:estado' => 'eventos#index', :as => :eventos_por_estado
  get 'busca/eventos/:ano/:month' => 'eventos#index', :as => :eventos_por_mes
  get 'cursos/tecnologia/:ano' => 'eventos#cursos', :as => :cursos
  get 'eventos/lista/:id' => 'eventos#lista',:as => :participantes
  get 'atividades/:nick' => 'atividades_do_usuario#index', :as => :atividades_do_usuario
  get '/:controller(/:action(/:id))'

  root :to => 'eventos#index'
end

