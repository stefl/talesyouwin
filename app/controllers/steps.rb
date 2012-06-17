TalesYouWin.controllers :steps do

  get :show, :map => "/tales/:tale_slug/steps/:slug" do
    not_found unless @tale = Tale.where(:slug => params[:tale_slug]).first
    not_found unless @step = @tale.steps.where(:slug => params[:slug]).first
    set_current_step @step
    @next_step = @tale.steps.where(:ordering => @step.ordering + 1).first
    render :"steps/show"
  end

  get :edit, :map => "/tales/:tale_slug/steps/:slug/edit" do
    not_found unless @tale = Tale.where(:slug => params[:tale_slug]).first
    not_found unless @step = @tale.steps.where(:slug => params[:slug]).first
    halt(403, "Not Authorized") unless @step.tale.account.id == current_account.id
    render :"steps/edit"
  end

  put :update, :map => "/tales/:tale_slug/steps/:slug/" do
    not_found unless @tale = Tale.where(:slug => params[:tale_slug]).first
    not_found unless @step = @tale.steps.where(:slug => params[:slug]).first
    @step.update_attributes(params[:step])
    redirect url_for(:tales, :manage, :slug => @tale.slug)
  end
  
  post :create, :map => "/tales/:slug/steps" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    halt(403, "Not Authorized") unless @tale.account.id == current_account.id
    @step = Step.new(params[:step])
    @step.tale = @tale
    @step.ordering = (@tale.steps.max(:ordering) || 0) + 1
    @step.save
    redirect url_for(:tales, :manage, :slug => @tale.slug)
  end

  delete :delete, :map => "/tales/:tale_slug/steps/:slug" do
    not_found unless @tale = Tale.where(:slug => params[:tale_slug]).first
    not_found unless @step = @tale.steps.where(:slug => params[:slug]).first
    @step.destroy
    redirect url_for(:tales, :manage, :slug => @tale.slug)
  end

end
 