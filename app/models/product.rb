class Product < ApplicationRecord
    include Notifications
    has_many :subscribers, dependent: :destroy
    has_one_attached :featured_image
    has_rich_text :description

    validates :name, presence: true
    validates :name, length: { maximum: 200 }

    validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

    validates :type, inclusion: { in: [ nil, "Book" ], allow_nil: true }
validates :author, presence: true, if: -> { is_a?(Book) }
validates :author, absence: true, unless: -> { is_a?(Book) }
end
