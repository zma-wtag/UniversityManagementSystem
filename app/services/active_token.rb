class ActiveToken
  def self.call(user)
    for token in user.access_tokens
      if !token.expired?
        return true
      end
    end
    return false
  end
end