# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Administrate::Punditize
    before_action :authenticate_user!
    before_action :authorize_admin
    before_action :set_locale
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    helper all_helpers_from_path 'app/helpers'

    def order
      @order ||= Administrate::Order.new(
        params.fetch(resource_name, {}).fetch(:order, default_sort[:order]),
        params.fetch(resource_name, {}).fetch(:direction, default_sort[:direction])
      )
    end

    # override this in specific controllers as needed
    def default_sort
      { order: :created_at, direction: :desc }
    end

    def set_locale
      I18n.locale = :en || I18n.default_locale
    end

    def authorize_admin
      authorize :admin, :show?
    end

    def user_not_authorized
      redirect_to root_path
    end

    def valid_action?(name, resource = resource_class)
      string_name = name.to_s
      if string_name == 'edit' && current_user.role == 'lab_space_admin'
        return false
      end
      routes.detect do |controller, action|
        controller == resource.to_s.underscore.pluralize && action == string_name
      end.present?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    private

    def read_param_value(data)
      super(data)
    rescue StandardError => error
      return GlobalID::Locator.locate(data[:value]) if data[:type] == PolymorphicWithUserField.to_s

      raise error
    end
  end
end
