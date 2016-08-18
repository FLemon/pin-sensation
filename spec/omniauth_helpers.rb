module OmniauthHelpers
  def mock_auth_with_user(options={})
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        name: "Google user",
        email: 'firstname.lastname@example.com',
        first_name: "Google",
        last_name: "User",
        image: ""
      }.merge(options),
      credentials: {
        token: "token",
        refresh_token: "another_token",
        expires_at: 1354920555,
        expires: true
      },
      extra: {
        id_token: 1000.times.map { "string" }.join, # this huge chunk is used to test for CookieOverflow exception
        raw_info: OmniAuth::AuthHash.new(
          email: "firstname.lastname@example.com",
          email_verified: "true",
          kind: "plus#personOpenIdConnect",
          name: "Test Person")
      }
    })
  end

  def mock_auth_with_invalid_domain
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end
