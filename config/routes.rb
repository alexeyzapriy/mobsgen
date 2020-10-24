Rails.application.routes.draw do
  resources :events
  resources :stoats, only: [:index, :show]
end
