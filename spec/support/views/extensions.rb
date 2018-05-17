module HelperMethodsInViews
  extend ActiveSupport::Concern

  def setup_with_controller
    super
    view.class_eval { include ViewHelperMethods }
  end

  module ViewHelperMethods
    attr_reader :current_user
    attr_accessor :current_user_session

    def current_user=(user)
      @current_user = user

      # Devise returns the current user from the @current_user
      # instance variable.
      controller.instance_variable_set(:@current_user, user)
    end

    def acts_as_panel(*); end
  end
end

