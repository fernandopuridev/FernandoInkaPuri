module Types
  class VeiculoType < Types::BaseObject
    field :id, ID, null: false
    field :marca, String
    field :modelo, String
    field :ano, Int
    field :placa, String
  end
end
