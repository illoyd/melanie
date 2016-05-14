Rails.application.routes.draw do

  resources :organizations do
    resources :notes
  end

  resources :people do
    resources :notes
  end

  resources :notes

  resources :hashtags, only: [:index, :show]
  resources :cashtags, only: [:index, :show]

  root 'people#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
