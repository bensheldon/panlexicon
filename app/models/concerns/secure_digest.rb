module SecureDigest
  extend ActiveSupport::Concern

  class << self
    attr_accessor :min_cost # :nodoc:
  end

  self.min_cost = false

  module ClassMethods
    def has_secure_digest(attribute = :token)
      # Load securerandom only when has_secure_digest is used.
      require 'active_support/core_ext/securerandom'
      define_method("regenerate_#{attribute}_digest") do |unencrypted_token = nil|
        unencrypted_token ||= self.class.generate_unique_secure_token_for_digest
        send "#{attribute}_digest=", secure_digest(unencrypted_token)
        unencrypted_token
      end

      define_method("authenticate_#{attribute}_digest") do |unencrypted_token|
        BCrypt::Password.new(send("#{attribute}_digest")) == unencrypted_token && self
      end

      def secure_digest(string)
        cost = SecureDigest.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
    end

    def generate_unique_secure_token_for_digest
      SecureRandom.base58(24)
    end
  end
end
