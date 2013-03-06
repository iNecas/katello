Rails.application.routes.draw do
  resources :activation_keys, :only => [:index]
end
