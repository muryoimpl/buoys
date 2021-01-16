Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'about'         => 'dummy#dummy', as: :about
  get 'about/history' => 'dummy#dummy', as: :history

  resources :users, only: [] do
    resources :items, only: %i(show edit)
  end
end
