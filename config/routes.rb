Rails.application.routes.draw do
  resources :users
  	root to: "pages#index"
	
  	get "login", to: "pages#show_login"
  	post "login", to: "pages#new_login"
  	get "logout", to: "pages#logout"

	resources :users
	resources :seat_classes
	resources :seats
	resources :flights
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
