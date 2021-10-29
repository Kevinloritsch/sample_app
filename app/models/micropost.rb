class Micropost < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :correct_image_type
  validates :image, size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
    

  private

  def correct_image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/gif image/png))
      errors.add(:image, "MUST be a correct file type.")
    end
  end
  

end
