module EasyTable::ViewExt::Table
  module Base
    def render_table options = {}, &block
      content_tag :table, :class => options[:table_class], :summary => options[:summary] do 
        yield block
      end
    end        

    def render_tbody collection, &block 
      do_tag 1, :tbody do
        table_body(collection, &block)
      end
    end

    def table_body collection, &block
      content = with_output_buffer(&block)
      collection.each do |obj|
        row_content = yield obj, row_class
        content << indent(2) + row_content
      end      
    end

    def render_caption caption
      do_tag 1, :caption, caption if caption
    end
  end
end