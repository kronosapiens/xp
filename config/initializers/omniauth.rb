github_client_id = Rails.application.secrets.github_client_id
github_client_secret = Rails.application.secrets.github_client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, github_client_id, github_client_secret, scope: "user:email, repo"
end