Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about' # リスト3.19
  # get  "static_pages/contact" # 演習3.4.3
  # # root "application#hello" # リスト3.5：デプロイするため
  # root "static_pages#home" # リスト3.42

  # リスト 5.26:静的なページのルーティング一覧
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  # get  "/help",    to: "static_pages#help", as: 'helf'
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new" #リスト5.42
  # リスト 8.2:リソースを追加して標準的なRESTfulアクションをgetできるようにする red
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users # リスト7.3
  resources :account_activations, only: [:edit] # リスト11.1
end
