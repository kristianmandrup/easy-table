require 'require_all'
require_all File.dirname(__FILE__) + '/table'
require 'easy-table/row'

module EasyTable::ViewExt
  module Table
    def table(collection, headers, options = {}, &block)
      obj_type = get_obj_type collection
      set_options! options
          
      return options[:placeholder] unless collection.any?

      options.delete :placeholder
      caption = options.delete :caption
      footer  = options.delete :footer

  
      table_tag options do   
        [
          caption_tag(caption),
          header_tag(headers),
          footer_tag(footer, headers),
          tbody_tag(collection, &block)
          
        ].compact.join.html_safe
      end
    end

    module Helper
      def table_tag options = {}, &block
        content_tag :table, options do
          yield.indent(0)
        end
      end
    end

    includes :base, :data
  end 
end


