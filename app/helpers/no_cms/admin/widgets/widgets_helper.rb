module NoCms::Admin::Widgets
  module WidgetsHelper

    def widget_listing_item_classes item, current
      classes = []
      classes << 'current' if current == item
      classes
    end

    def block_form_classes block
      classes = []
      classes << 'oculto' if block.draft
      classes << 'new' if block.new_record?
      classes
    end

    def block_form_id block
      block.new_record? ?
      "new_content_block_#{block.layout}" :
      "content_block_#{block.id}"
    end

  end
end