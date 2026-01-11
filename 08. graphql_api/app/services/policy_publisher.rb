require 'bunny'

class PolicyPublisher
  def self.publish(msg, queue)
    connection = Bunny.new(host:  'rabbitmq')
    connection.start
    channel = connection.create_channel

    q = channel.queue(queue, durable: true)

    channel.default_exchange.publish(msg, routing_key: q.name)
    puts " [x] Sent 'Hello World!'"
    connection.close
  end

  # def self.connection
  #   @connection ||= Bunny.new.tap do |con|
  #     con.start
  #   end
  # end

  # def self.channel
  #   @channel = connection.create_channel
  # end
end
