Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts
  resources :comments

  get 'new_post_modal' => 'posts#new_post_modal'
  get 'search_by_title' => 'posts#search_by_title'
end
