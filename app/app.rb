class TalesYouWin < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Admin::AccessControl

  enable :sessions

  use OmniAuth::Builder do
    provider :twitter, 'U8GlH8JBv4vq2693ry7wng', 'Iq5hmw1EylTN7tlTNzUYWZjRaWyCsEOSC6PkduTDY'
  end

  access_control.roles_for :any do |role|
    role.protect "/profile"
    role.protect "/admin"
  end

  access_control.roles_for :users do |role|
    role.allow "/profile"
  end

end
