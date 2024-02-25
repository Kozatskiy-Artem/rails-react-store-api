class Item < ApplicationRecord
    has_many :orders_descriptions, dependent: :destroy
end
