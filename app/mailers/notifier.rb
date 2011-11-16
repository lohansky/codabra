class Notifier < ActionMailer::Base
  default from: '"Codabra Notifier" <notifier@codabra.com>'

  def password_reset_instructions(codabra)
    @edit_password_url = edit_password_url(codabra.password_salt)

    mail to: codabra.email_with_name, subject: t(:'notifier.subjects.password_reset_instructions')
  end
end
