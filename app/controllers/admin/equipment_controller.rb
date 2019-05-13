module Admin
  class EquipmentController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Equipment.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Equipment.find_by!(slug: param)
    # end

    def destroy
      @equipment = Equipment.find(params[:id])
      @equipment.update_attribute(:hidden, true)
      flash[:notice] = 'Equipment was successfully hidden.'
      redirect_to admin_equipment_index_path
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
