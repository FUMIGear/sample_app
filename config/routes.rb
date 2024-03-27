Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about' # リスト3.19
  get  "static_pages/contact" # 演習3.4.3
  # root "application#hello" # リスト3.5：デプロイするため
  root "static_pages#home" # リスト3.42

end
