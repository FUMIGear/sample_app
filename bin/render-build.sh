# リスト 10.65:ビルドスクリプトにdb:migrate:resetとdb:seedを追加する
# リスト6.45：ビルドスクリプトを作成する
#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# bundle exec rails db:migrate
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset
bundle exec rails db:seed
