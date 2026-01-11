class PropertyType < ApplicationRecord
    has_many :properties
    validates :name, presence: {message:'Campo não pode estar em branco!'}
    validates :name, uniqueness: { message: 'Esse Tipo de imóvel já existe!'}
end
