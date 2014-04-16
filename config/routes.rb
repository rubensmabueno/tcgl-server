TcglServer::Application.routes.draw do
  root :to => "home#index"

  resources :home
  resources :horarios do
    post :index, :on => :collection
  end

  resources :linhas do
    post :posicoes, :on => :collection
    post :partidas, :on => :collection
    post :chegadas, :on => :collection
    post :itinerarios, :on => :collection

    resources :dias do
      resources :pontos do
        resources :destinos
      end
    end
  end
end
