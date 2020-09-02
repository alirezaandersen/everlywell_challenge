Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :friendships, only: %i[create], defaults: { format: :json } do
    collection do
      get :show_friends
    end
  end

  resources :users, only: %i[index show create], defaults: { format: :json } do
    collection do
      get :search_for_expert
    end
  end
end
