class Property < ApplicationRecord
    belongs_to :property_type
    belongs_to :property_location
    belongs_to :property_owner
    has_many :property_reservations, dependent: :destroy
    
    validates :title, :description, :rooms, :bathrooms, :daily_rate, 
    presence: { message: "não pode ficar em branco!"}
end
