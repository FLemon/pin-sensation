class ItemChannelJS
  def initialize
    @cable = Cable.cable
  end

  def subscribe_items
    @cable.subscriptions.create('ItemsChannel', received: ->(data) do
      digest_data(Native(data))

      case @action
      when 'create'
        element.prepend(list_template)
      when 'destroy'
        Element["#items li[name='item_#{@item['id']}'"].remove
      else
      end
    end)
  end

  private
  def element
    Element['#items']
  end

  def digest_data(data)
    @action = data.action
    @item = data.item
    @template = data.template
  end

  def list_template
    "<li>#{@template}</li>
    <li class='divider'></li>"
  end
end

# Cable.subscribe_items
ItemChannelJS.new.subscribe_items
