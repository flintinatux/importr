class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  if Rails.env.production?
    http_basic_authenticate_with name: ENV['BASIC_NAME'], password: ENV['BASIC_PASSWORD']
  end

  def correct_user
    unless current_user? object.user
      flash[:error] = "#{klass_name} ##{object.id} is not yours!"
      redirect_to root_path
    end
    instance_variable_set "@#{klass_name.downcase}", object
  end

  private

    def klass_name
      @klass_name ||= controller_name.classify
    end

    def object
      @object ||= klass_name.constantize.find(params[:id])
    end
end
