# frozen_string_literal: true

module Types
  class SeguradoType < Types::BaseObject
    field :id, ID, null: false
    field :nome, String
    field :cpf, String
  end
end
