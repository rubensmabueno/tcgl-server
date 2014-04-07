TcglServer::Application.routes.draw do
  root :to => "home#index"

  resources :home

  resources :linhas do
    resources :dias do
      resources :pontos do
        resources :destinos do
          resources :horarios
        end
      end
    end
  end
end
