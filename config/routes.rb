Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
  namespace :v1 do
    resources :clock_ins, only: [:create, :index]
    resources :users do
      member do
        post :follow_users
        delete :unfollow_user
      end
    end
    get '/sleep_records/following_users', to: 'sleep_records#following_users'
  end
end
  # Defines the root path route ("/")
  # root "articles#index"
end
