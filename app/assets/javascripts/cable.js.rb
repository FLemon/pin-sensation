require 'action_cable'

class Cable
  def self.cable=(value)
    @@cable = value
  end

  def self.messages=(value)
    @@messages = value
  end

  def self.subscribe_messages
    @@cable.subscriptions.create('MessagesChannel', received: ->(data) do
      Element['#messages'].remove_class('hidden')
      Element['#messages'].append(renderMessage(Native(data)))
    end)
  end

  def self.renderMessage(data)
    "<p> <b>" + data.user + ": </b>" + data.message + "</p>"
  end

  def self.create_consumer
    @@cable = Native(`ActionCable`).createConsumer
  end
end
