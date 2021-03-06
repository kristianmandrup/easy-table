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

  
      render_table options do   
        [
          render_caption(caption),
          render_header(headers),
          render_footer(footer, headers),
          render_tbody(collection, &block)
        ].compact.join.html_safe
      end
    end

    includes :base, :data
  end 
end
