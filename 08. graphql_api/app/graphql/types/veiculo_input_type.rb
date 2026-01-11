module Types
  class VeiculoInputType < BaseInputObject
    argument :marca, String, required: true
    argument :modelo, String, required: true
    argument :ano, Int, required: true
    argument :placa, String, required: true
  end
end