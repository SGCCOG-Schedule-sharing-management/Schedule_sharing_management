Rails.application.routes.draw do

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root "homes#index"
    get '/mypage' => 'users#show', as: 'mypage'
    get '/information/edit' => 'users#edit', as: 'edit_information'
    patch '/information' => 'users#update', as: 'update_information'
    put '/information' => 'users#update'
    resources :schedules, only: [:index, :show]
    resources :groups, only:[:index, :show]
    resources :group_participation_applications, only:[:new, :create, :show]

  end 

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :groups
    resources :group_participation_applications, only:[:index, :show, :update]
    
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
