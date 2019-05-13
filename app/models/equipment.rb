class Equipment < ApplicationRecord
  audited

  mount_uploader :image, ImageUploader

  has_many :equipment_materials, dependent: :destroy
  has_many :materials, through: :equipment_materials, after_remove: :destroy_orphans
  has_many :equipment_capabilities, dependent: :destroy
  has_many :capabilities, through: :equipment_capabilities, after_remove: :destroy_orphans
  has_many :available_hours, dependent: :destroy
  has_many :reservations
  belongs_to :lab_space

  validates :name, :description, :lab_space, presence: true

  accepts_nested_attributes_for :available_hours

  scope :visible, -> { where(hidden: false) }

  def self.search(name)
    if name.present?
      where('equipment.name ILIKE ?', "%#{name}%")
    else
      Equipment.all
    end
  end

  def self.search_by(relation, query)
    if query.present?
      names = query.split(/[,]+/).collect(&:strip)
      joins(relation).where("#{relation}.name ILIKE ANY ( array[?] )", names).distinct
    else
      all
    end
  end

  def self.materials
    Material.joins(:equipment).where(equipment: { id: ids })
  end

  def self.capabilities
    Capability.joins(:equipment).where(equipment: { id: ids })
  end

  def upcoming_reservations
    reservations.future.count
  end

  def self.check_for_new_tags(tags, tag_class)
    tags.each_with_index do |tag, index|
      next unless tag.present? && !tag.match?(/\A\d+\Z/) # Skip if tag is an ID

      new_tag = 'FAIL' # Should never happen if called function is called correctly
      new_tag = Material.find_or_create_by(name: tag) if tag_class == :material
      new_tag = Capability.find_or_create_by(name: tag) if tag_class == :capability
      tags[index] = new_tag.id
    end
    tags
  end

  private

  def destroy_orphans(tag)
    tag.destroy_if_orphaned
  end
end
