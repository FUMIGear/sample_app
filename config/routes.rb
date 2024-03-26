Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about' # リスト3.19
  root "application#hello" # リスト3.5：デプロイするため
end
