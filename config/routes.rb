Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  root "application#hello" # リスト3.5：デプロイするため
end
