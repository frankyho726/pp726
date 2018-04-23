class User < ApplicationRecord
     attr_accessor :remember_token, :activation_token
     before_save   :downcase_email  #11.3 amend
     before_create :create_activation_digest #11.3 add
#    before_save { email.downcase! }
#    self.email = email.downcase #6.32
     validates :name,  presence: true, length: { maximum: 50 } #6.16：为 name 属性添加长度验证 GREEN
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
     validates :email, presence: true, length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }
     has_secure_password
     validates :password, presence: true, length: { minimum: 6 }, allow_nil: true #10.13 add allow_nil: true
 
  # 返回指定字符串的哈希摘要
#  def self.digest(string)
#    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                  BCrypt::Engine.cost
#    BCrypt::Password.create(string, cost: cost)
#  end
  
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
   # 返回一个随机令牌
#    def self.new_token
#     SecureRandom.urlsafe_base64
#    end
    
    def User.new_token
     SecureRandom.urlsafe_base64
    end
    
     # 为了持久保存会话，在数据库中记住用户
    def remember
    self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
    
          # Returns true if the given token matches the digest. 11.26 very funny topic to learn
    def authenticated?(attribute, token)
       digest = send("#{attribute}_digest")
       return false if digest.nil?
       BCrypt::Password.new(digest).is_password?(token)
    end 
#      def authenticated?(remember_token)
#      return false if remember_digest.nil?
#      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  
      # 忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end
  
   # Activates an account. 11.35
  def activate
#    update_attribute(:activated,    true)
#    update_attribute(:activated_at, Time.zone.now)
    update_columns(activated: true, activated_at: Time.zone.now) #ex 11.39
  end

  # Sends activation email. 11.35
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  
#########  
  private

    # Converts email to all lower-case.
    def downcase_email
        email.downcase! # exercises in 11.1 ex 3
#      self.email = email.downcase
#      debugger
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
#      debugger
      self.activation_digest = User.digest(activation_token)
    end
    
end
