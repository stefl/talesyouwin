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
    halt(403, "Not Authorized") unless @step.tale.account == current_account
    render :"steps/edit"
  end
  
  post :create, :map => "/tales/:slug/steps" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    halt(403, "Not Authorized") unless @tale.account == current_account
    @step = Step.new(params[:step])
    @step.tale = @tale
    @step.ordering = (@tale.steps.max(:ordering) || 0) + 1
    @step.save
    redirect url_for(:tales, :edit, :slug => @tale.slug)
  end

end
 