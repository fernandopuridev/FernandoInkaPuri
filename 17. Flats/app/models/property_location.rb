class PropertyLocation < ApplicationRecord
    has_many :properties
    validates :name, presence: { message:'Campo não pode estar em branco!' }
    validates :name, uniqueness: { message: 'Essa Região já existe, tente outra!', case_sensitive:false }
end
