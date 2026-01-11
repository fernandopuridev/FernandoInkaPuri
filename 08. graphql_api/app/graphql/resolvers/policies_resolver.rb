require 'net/http'

module Resolvers
  class PoliciesResolver < BaseResolver
    type [Types::PolicyType], null: false
    # argument tem??

    def resolve
      response = Net::HTTP.get(URI("http://rest_api:3005/policies"))

      Rails.logger.info(response)
      JSON.parse(response)
    end
  end
end