Rails.application.routes.draw do
    namespace :api do
        resources :users
    end
	root 'application#hello'
end
