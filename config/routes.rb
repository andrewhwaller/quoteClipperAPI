Rails.application.routes.draw do
	namespace :api, defaults: { format: :json } do
		namespace :v1 do
			resources :users, only: %i[create show update destroy]
            resources :tokens, only: [:create]
            resources :quotes, only: %i[show index]
		end
	end
end
