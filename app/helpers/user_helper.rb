module UserHelper
  def managed_resources(resource, directly_managed_resources, indirectly_managed_resources)
    return resource.all if role == 'superadmin'

    resources = resource.find_by_sql("(#{directly_managed_resources.to_sql}) UNION (#{indirectly_managed_resources.to_sql})")
    resource.where(id: resources.map(&:id))
  end
end
