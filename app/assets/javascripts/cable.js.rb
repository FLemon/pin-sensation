require 'action_cable'

class Cable
  def self.subscribe_messages
    @@cable.subscriptions.create('MessagesChannel', received: ->(data) do
      Element['#messages'].remove_class('hidden')
      Element['#messages'].append(renderMessage(Native(data)))
    end)
  end

  def self.subscribe_items
    @@cable.subscriptions.create('ItemsChannel', received: ->(data) do
      Element['#items'].append(renderItem(Native(data)))
    end)
  end

  def self.renderItem(data)
    "<tr>
      <td>#{data.name}</td>
      <td>#{data.content}</td>
      <td>#{data.comment}</td>
    </tr>"
  end

  def self.renderMessage(data)
    "<p> <b>" + data.user + ": </b>" + data.message + "</p>"
  end

  def self.create_consumer
    @@cable = Native(`ActionCable`).createConsumer
  end
end
