Rails.application.routes.draw do
	resources :lists
	resources :users

	root 'login#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
