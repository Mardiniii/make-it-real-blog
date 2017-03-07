Rails.application.routes.draw do
  root 'posts#index'

  get 'posts/new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  get 'posts/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
