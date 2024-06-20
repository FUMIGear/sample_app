class User < ApplicationRecord
  attr_accessor :remember_token # リスト9.3
  # before_save { self.email = email.downcase }
  before_save { email.downcase! }
  #リスト6.9name属性の存在性を検証する
  # validates :name, presence: true
  # リスト 6.12:email属性の存在性を検証する
  # validates :email, presence: true
  # リスト6.16：name属性とemail属性に長さの検証を追加する
  validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #リスト6.21
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i # リスト6.23
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX }, #リスト6.21
  uniqueness: true
  # uniqueness: { case_sensitive: false } #リスト6.27
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 元コード
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # ランダムなトークンを返す
  # リスト 9.2:トークン生成用メソッドを追加する
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # リスト 9.4:selfを使ってdigestとnew_tokenメソッドを定義する
  # 渡された文字列のハッシュ値を返す
  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end
  # # ランダムなトークンを返す
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # リスト 9.5:class << selfを使ってdigestとnew_tokenメソッドを定義する green
  # app/models/user.rb
  # class << self
  #   # 渡された文字列のハッシュ値を返す
  #   def digest(string)
  #     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #     BCrypt::Password.create(string, cost: cost)
  #   end
  #   # ランダムなトークンを返す
  #   def new_token
  #     SecureRandom.urlsafe_base64
  #   end
  # end

  # リスト 9.3:rememberメソッドをUserモデルに追加する
  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest # リスト9.37追加分
  end
  
  # リスト 9.37:session_tokenメソッドをユーザーに追加する
  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end

  # リスト 9.6:authenticated?をUserモデルに追加する
  # リスト 9.20:authenticated?を更新して、ダイジェストが存在しない場合に対応 green
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil? # 追加分
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # リスト 9.11:forgetメソッドをUserモデルに追加する
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
