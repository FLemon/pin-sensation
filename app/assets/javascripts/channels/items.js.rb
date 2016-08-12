class ItemChannelJS
  def initialize
    @cable = Cable.cable
  end

  def subscribe_items
    @cable.subscriptions.create('ItemsChannel', received: ->(data) do
      digest_data(Native(data))

      case @action
      when 'create'
        Element["#list"].prepend(@template)
      when 'destroy'
        Element["#list li[name='item_#{@item['id']}'"].remove
      else
      end
    end)
  end

  private

  def digest_data(data)
    @action = data.action
    @item = data.item
    @template = data.template
  end
end

# Cable.subscribe_items
ItemChannelJS.new.subscribe_items
