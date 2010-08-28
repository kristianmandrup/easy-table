module EasyTable::ViewExt::Table
  module Body
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
      content.join.html_safe
    end
  end
end