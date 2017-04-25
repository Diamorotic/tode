Rails.application.routes.draw do
	resources :users do
		resources :lists
	end

	root 'login#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
