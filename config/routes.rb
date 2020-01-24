Rails.application.routes.draw do
	namespace :api, defaults: { format: :json } do
		namespace :v1 do
			resources :users, only: [:create, :show, :update, :destroy, :login] do
				collection do
					post "login"
				end
			end
            resources :tokens, only: [:create]
            resources :quotes
		end
	end
end
