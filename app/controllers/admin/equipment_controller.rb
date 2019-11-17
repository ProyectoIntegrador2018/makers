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
      @equipment.update_attribute(:hidden, !@equipment.hidden)
      flash[:notice] = "Equipment was successfully #{@equipment.hidden ? 'hidden' : 'unhidden'}."
      redirect_to admin_equipment_index_path
    end

    def show
      @equipment = Equipment.find(params[:id])
      super
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      filter_tags
      super
    end

    def create
      filter_tags
      super
    end

    private

    def filter_tags
      params[:equipment][:material_ids] = Equipment.check_for_new_tags(params[:equipment][:material_ids], :material)
      params[:equipment][:capability_ids] = Equipment.check_for_new_tags(params[:equipment][:capability_ids], :capability)
    end
  end
end
