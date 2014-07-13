Rails.application.routes.draw do
  root :to => "home#index"

  resources :home

  resources :lines, :only => [:index, :show] do
    get :positions, :on => :collection
    get :itineraries, :on => :member

    get :near_stops, :on => :collection

    resources :days, :only => :index do
      resources :origins, :only => :index do
        resources :destinations, :only => :index do
          resources :schedules, :only => :index
        end
      end
    end
  end
end
