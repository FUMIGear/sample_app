class ApplicationController < ActionController::Base
  # リスト3.4:Renderでデプロイするため
  def hello
    render html: "hello, world!"
  end
end
