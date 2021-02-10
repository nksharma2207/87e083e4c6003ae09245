Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope('api') do
    resources :robot, only: [] do
      post :orders, on: :member, format: :json
    end
  end
end
