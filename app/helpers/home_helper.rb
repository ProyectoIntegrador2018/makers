module HomeHelper
  def apply_query(options = {})
    # Define some variables
    type_id = params[:type].singularize + '_id'
    selected_item = params[:selectedItem]
    # Get all the results
    results = options[:type_table].select(:id, :name)
    # Check if an item of the other category was chosen
    if selected_item.present?
      # Get equipment ids that use the selected item
      equipments = options[:other_equipment_type_table].select(:equipment_id).where("#{options[:other_type_id]} = ?", selected_item).map(&:equipment_id)
      # Get the desired items of the equipments selected
      item_ids = options[:equipment_type_table].select(type_id).where(equipment_id: equipments).map { |item| item[type_id] }
      # Get the name of the items selected
      results = results.where(id: item_ids)
    end
    results
  end
end
