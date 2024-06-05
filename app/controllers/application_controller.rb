class ApplicationController < ActionController::Base
  # リスト 8.13:ApplicationコントローラにSessionヘルパーモジュールを読み込む
  include SessionsHelper

  # リスト3.4:Renderでデプロイするため
  def hello
    render html: "hello, world!"
  end
end
