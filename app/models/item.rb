class Item < ApplicationRecord
  STATUSES = %w[lost found]

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :photo

  validates :title, :location, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :description, length: { maximum: 500 }
  validate :photo_is_an_image

  scope :newest_first, -> { order(created_at: :desc) }

  def lost?
    status == "lost"
  end

  private
    def photo_is_an_image
      return unless photo.attached?

      errors.add(:photo, "must be an image (JPG, PNG, GIF or WebP)") unless photo.content_type.in?(%w[image/jpeg image/png image/gif image/webp])
      errors.add(:photo, "must be smaller than 5 MB") if photo.byte_size > 5.megabytes
    end
end
