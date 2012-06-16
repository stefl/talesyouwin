TalesYouWin.controllers :tales do
  get :index, :map => "/" do
    render :'tales/index'
  end

  get :new, :map => "/tales/new" do
    render :'tales/new'
  end

  get :show, :map => "/tales/:slug" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    render :'tales/show'
  end

  get :edit, :map => "/tales/:slug/edit" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    render :'tales/edit'
  end

  get :manage, :map => "/tales/:slug/manage" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    render :'tales/manage'
  end

  get :play, :map => "/tales/:slug/play" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    redirect url_for(:steps, :show, :tale_slug => @tale.slug, :slug => current_step(@tale).slug)
  end

  get :end, :map => "/tales/:slug/end" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    session[:tales][@tale.id.to_s] = []
    redirect "/" 
  end

  put :update, :map => "/tales/:slug" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    @tale.update_attributes(params[:tale])
    redirect url_for(:tales, :show, :slug => @tale.slug)
  end

  post :create ,:map => "/tales" do
    @tale = Tale.new(params[:tale])
    @tale.account = current_account
    @tale.save
    redirect url_for(:tales, :show, :slug => @tale.slug)
  end

end
