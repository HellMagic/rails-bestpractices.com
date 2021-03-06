CanCan::ControllerResource.class_eval do
  def resource_params_with_strong_parameters
    if @controller.respond_to?(:resource_params)
      @controller.send(:resource_params)
    else
      resource_params_without_strong_parameters
    end
  end

  alias_method_chain :resource_params, :strong_parameters
end
