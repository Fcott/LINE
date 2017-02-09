Rails.application.routes.draw do

  get 'messages/index'

  root to: "pages#home"


  devise_for :users,
             :path => '',
             :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => { :omniauth_callbacks => "omniauth_callbacks",
                               :registrations => 'registrations'}

  resources :users, only: [:index, :show]
  resources :rooms, only: [:index, :show, :create]
end
