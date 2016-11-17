Rails.application.routes.draw do

  root "restaurants#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :reviews
  end
end
