class User < ApplicationRecord
    before_save { email.downcase! }
  #  self.email = email.downcase #6.32
   validates :name, presence: true #6.9：为 name 属性添加存在性验证 GREEN
   validates :email, presence: true
   
     validates :name,  presence: true, length: { maximum: 50 } #6.16：为 name 属性添加长度验证 GREEN
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
     validates :email, presence: true, length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }
     has_secure_password
     validates :password, presence: true, length: { minimum: 6 }
  # 返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
