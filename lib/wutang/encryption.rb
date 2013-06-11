module Wutang
  class Encryption
    SEPARATOR = ":36_chambers:"

    attr_accessor :key, :aes

    def initialize(passphrase)
      @aes         = ::OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      @aes.padding = 1
      @key         = Digest::SHA256.digest(passphrase)
    end

    def encrypt(value)
      return value if value == '' || value.nil?
      aes.encrypt
      aes.key = key
      Base64::encode64("#{aes.random_iv}#{SEPARATOR}#{aes.update(value.to_s) + aes.final}")
    end

    def decrypt(value)
      return value if value == '' || value.nil?
      iv, value = Base64::decode64(value.to_s).split(SEPARATOR)
      aes.decrypt
      aes.key = key
      aes.iv  = iv
      aes.update(value) + aes.final
    end
  end
end
