Rails.application.routes.draw do

  # ユーザー用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
scope module: :public do
  get 'users/mypage' => 'users#show', as: 'mypage'
  get 'users/information/edit' => 'users#edit', as: 'edit_information'
  patch 'users/information' => 'users#update', as: 'update_information'
  put 'users/information' => 'users#update'
end 

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  get 'top' => 'homes#top', as: 'top'
  
  
end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
