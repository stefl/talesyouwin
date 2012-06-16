# Helper methods defined here can be accessed in any controller or view in the application

TalesYouWin.helpers do
  def current_step tale
    puts "BEFORE WE START"
    puts session[:tales]
    return @current_step if @current_step
    session[:tales] ||= {}
    session[:tales][tale.id.to_s] ||= [tale.steps.first.id.to_s]
    @current_step = Step.find(session[:tales][tale.id.to_s].last) rescue tale.steps.first
  end

  def set_current_step step
    puts "SET CURRENT STEP"
    puts step.inspect
    session[:tales] ||= {}
    session[:tales][step.tale.id.to_s] ||= []
    session[:tales][step.tale.id.to_s] << step.id.to_s
    puts session.inspect
    puts "DONE"
  end
end
