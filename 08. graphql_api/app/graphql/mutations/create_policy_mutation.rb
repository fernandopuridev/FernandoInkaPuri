class Mutations::CreatePolicyMutation < Mutations::BaseMutation
  argument :policy, Types::PolicyInputType, required: true

  field :result, String, null: true

  def resolve(policy:)


    PolicyPublisher.publish(policy.to_h.to_json, 'create_policy')
    { "result" => "OK" }


  rescue StandardError => e
    raise GraphQL::ExecutionError, e.message
  end
end