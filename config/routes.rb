Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :sleep_trackings, only: [:index]do
        collection do
          post 'clock_in', to: 'sleep_trackings#clock_in'
          patch 'clock_out', to: 'sleep_trackings#clock_out'
        end
      end
      resources :users do
        member do
          post :follow_users
          delete :unfollow_user
        end
      end
    end
  end
end