class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    
    before_save  :downcase_email
    before_create :create_activation_digest
    
    
    validates :name, presence: true, length: {:maximum => 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: {:maximum => 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    validates :password, presence: true, length: {:minimum => 6}, allow_nil: true
    
    has_secure_password
    

     # Returns the hash digest of the given string.
    #  this method is used to generate heshed strings for the fixtures and remember_token to be strored in the db as remember_digest
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #  Returns a random token
    #  class method - used in the class itself
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    # instance method - can be used in an instance of a class
    # generates a remember tokenn and saves it digest to the database
    def remember
        self.remember_token = User.new_token
        # this method bypasses the validations because we don't have access to users password
        update_attribute(:remember_digest, User.digest(remember_token)) 
        remember_digest
    end

    def authenticated? remember_token
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # forget a user
    def forget
        update_attribute(:remember_digest, nil)
    end

    # returns a session token to prevent seesion hijacking
    def session_token
        remember_digest || remember
    end

    private

        # converts the email to all lowercase
        def downcase_email
            self.email.downcase!
        end

        # creates and assigns the activation token and diest
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end


end
