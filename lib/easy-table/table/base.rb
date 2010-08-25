require 'easy-table/row'

module EasyTable::ViewExt::Table
  module Base
    def render_table options = {}, &block
      content_tag :table, options do
        with_output_buffer(&block).indent(0)
      end
    end        

    def render_tbody collection, options={}, &block 
      indent_tag 1, :tbody do
        table_body(collection, options, &block).indent(1)
      end
    end

    def table_body collection, options = {}, &block
      content = []
      collection.each do |obj|
        content << with_output_buffer { yield obj, options }
      end      
      content.join
    end

    def render_caption caption
      indent_tag(1, :caption, caption) if !caption.blank?
    end
  end
end