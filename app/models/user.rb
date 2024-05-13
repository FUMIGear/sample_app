class User < ApplicationRecord
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
  validates :password, presence: true, length: { minimum: 8 }
end
