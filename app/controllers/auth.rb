TalesYouWin.controllers :auth do

  get :auth, :map => '/auth/:provider/callback', :provides => [:html, :json] do
    auth    = request.env["omniauth.auth"]
    account = nil
    if account = Account.where(:provider => auth["provider"], :uid => auth["uid"]).first
      flash[:success] = "Hi! Welcome back...." if content_type == :html
    else
      flash[:success] = "Welcome..." if content_type == :html
      account = Account.create_with_omniauth(auth)
    end
    set_current_account(account)
    case content_type
    when :json
      auth.to_json
    when :html
      redirect "http://" + request.env["HTTP_HOST"] + "/"
    end
  end

  get :destroy, :map => "/sign_out" do
    set_current_account(nil)
    redirect "/"
  end

  get :failure, :map => "/auth/failure" do
    redirect "/"
  end
end