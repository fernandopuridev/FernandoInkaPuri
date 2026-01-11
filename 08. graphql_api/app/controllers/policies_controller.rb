class PoliciesController < ApplicationController
  def index
    payload_param
  end

  def new
  end

  def create
    PolicyPublisher.publish(payload_param)
  end

  def payload_param
    @payload ||= params[:payload]
  end
end
