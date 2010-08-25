module EasyTable::ViewExt::Table
  module Data
    def data_table(collection, headers, options = {})    
    obj_type = get_obj_type collection
    set_options! options

    content = with_output_buffer(&block)    
    unless collection.any?        
      content = placeholder 
      return content
    end          

    # try to extract attributes from headers!
    attributes = options[:attributes] || extract_attributes(collection.first, headers)

    arg_err = "You must specify an :attributes hash option to indicate which attributes of #{obj_type.camelize} should be rendered in the table!"
    raise ArgumentError, arg_err if !attributes.any?

    classes = options[:classes] || []

    render_table options do
      render_caption options[:caption]            
      render_header headers
      render_footer options[:footer]  
      do_tag 1, :tbody do
        rows collection, attributes, classes
      end
    end      
    end

    def extract_attributes obj, headers
    headers.map do |header|
      attrib = header.to_s.underscore
      obj.respond_to?(attrib) ? attrib : nil
    end.compact
  end
end  