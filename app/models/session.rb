class Session < Authlogic::Session::Base
  generalize_credentials_error_messages I18n.t(:'errors.wrong_login_or_password')
  authenticate_with Codabra
end
