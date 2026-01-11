# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # description "The query root of this schema"
    # field :post, resolver: Resolvers::PostResolver (Exemplo da Doc)
    field :policy, resolver: Resolvers::PolicyResolver
    field :policies, resolver: Resolvers::PoliciesResolver
  end
end
