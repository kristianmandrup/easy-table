module EasyTable::ViewExt::Table
  module Body
    def table_body collection, options = {}, &block
      content = []
      collection.each do |obj|
        content << with_output_buffer { yield obj, options }
      end      
      content.join.html_safe
    end
  end
end