require_all File.dirname(__FILE__) + '/table'

module EasyTable::ViewExt
  module Table
    def table(collection, headers, options = {}, &block)
      obj_type = get_obj_type collection
      set_options! options

      content = with_output_buffer(&block)    
      unless collection.any?        
        content = placeholder 
        return content
      end          
  
      render_table options do
        render_caption options[:caption]            
        render_header headers
        render_footer options[:footer], headers  
        render_tbody collection, &block       
      end
    end

    includes :base, :util, :data
  end 
end
