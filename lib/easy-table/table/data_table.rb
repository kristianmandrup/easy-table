module EasyTable::ViewExt::Table
  module Data
    def data_table(collection, headers, options = {})    
      obj_type = get_obj_type collection
      set_options! options

      return options[:placeholder] unless collection.any?

      # try to extract attributes from headers!
      attributes = options[:attributes] || extract_attributes(collection.first, headers)

      arg_err = "You must specify an :attributes hash option to indicate which attributes of #{obj_type.camelize} should be rendered in the table!"
      raise ArgumentError, arg_err if !attributes.any?

      rows_options = options.delete(:rows) || {}

      options.delete :placeholder
      caption = options.delete :caption
      footer  = options.delete :footer

     
      render_table options do
        [
          render_caption(caption),
          render_header(headers),
          render_footer(footer, headers),
          indent_tag(1, :tbody) do
            data_rows(collection, attributes, rows_options).indent 1
          end
        ].compact.join
      end
    end

    def extract_attributes obj, headers
      headers.map do |header|
        att = header.to_s.underscore
        attrib = obj.send att
        att ? att : nil
      end.compact
    end
    
    def set_options! options={}, obj_type=nil
      options.reverse_merge!({
        :placeholder  => 'Nothing to display',
        :caption      => nil,
        :summary      => nil,
        :footer       => '',
        :class        => obj_type
      })           
    end  
    
    def get_obj_type collection
      collection.first.class.to_s      
    end    
  end
end  