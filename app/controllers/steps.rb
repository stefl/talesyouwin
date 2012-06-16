TalesYouWin.controllers :steps do

  get :show, :map => "/tales/:tale_slug/steps/:slug" do
    not_found unless @tale = Tale.where(:slug => params[:tale_slug]).first
    not_found unless @step = @tale.steps.where(:slug => params[:slug]).first
    puts "CREATE STEP"
    puts session[:tales].inspect
    set_current_step @step
    puts session[:tales].inspect
    @next_step = @tale.steps.where(:ordering => @step.ordering + 1).first
    render :"steps/show"
  end
  
  post :create, :map => "/tales/:slug/steps" do
    not_found unless @tale = Tale.where(:slug => params[:slug]).first
    @step = Step.new(params[:step])
    @step.tale = @tale
    @step.ordering = @tale.steps.max(:ordering) + 1
    @step.save
    redirect url_for(:tales, :edit, :slug => @tale.slug)
  end

end
 