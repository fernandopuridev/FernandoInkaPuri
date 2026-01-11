require 'net/http'

module Resolvers
  class PolicyResolver < BaseResolver
    type Types::PolicyType, null: false
    argument :policy_id, ID, required: true

    def resolve(policy_id:)
      response = Net::HTTP.get(URI("http://rest_api:3005/policies/#{policy_id}"))

      Rails.logger.info(response)
      JSON.parse(response)
    end
  end
end