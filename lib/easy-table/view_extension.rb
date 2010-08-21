require 'active_support/inflector'

module EasyTable
  module ViewExtension                                 

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
        render_footer options[:footer]  
        render_tbody collection, &block       
      end
    end

    def set_options! options={}
      options.reverse_merge!({
        :placeholder  => options[:placeholder] || 'Nothing to display',
        :caption      => nil,
        :summary      => nil,
        :footer       => ''
        :table_class  => obj_type
      })           
    end

    def get_obj_type collection
      collection.first.class.to_s      
    end

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

    def render_header headers
      return if !headers.any?
    
      do_tag 1, :thead do
        do_tag 2, :tr do
          headers.collect { |h| do_tag 3, :th, h }
        end
      end  
    end

    def render_footer footer
      return if !footer
      do_tag 1, :foot do
        do_tag 2, :tr do      
          do_tag 3, :th, footer, :colspan => headers.size 
        end
      end  
    end

    def rows collection, attributes, classes=nil
      content = ''
      collection.each do |obj|                  
        row_content = data_row(obj, attributes, get_row_class(classes))
        content << indent(2) + row_content
      end      
      content
    end
      
    def row post, clazz, &block
      do_tag 2, :tr, :class => clazz, yield post
    end

    def data_row object, attributes, clazz
      row clazz do
        attributes.each do |attrib|      
          cell object, attrib, clazz=nil      
        end
      end
    end

    def cells object, attributes, classes=nil
      attributes.each_with_index do |attrib, index|
        cell object, attrib, get_row_class(classes)
      end
    end
  
    def cell object, attribute, clazz=nil
      value = object.send attribute if object.respond_to? attribute
      do_tag 3, :td, :class => clazz, value || "Unknown attribute: #{attribute}"
    end

    def get_row_class classes
      classes.any? ? cycle(classes) : row_class
    end

    def row_class 
      cycle('odd', 'even')
    end
  
    def do_tag lv, *args, &block        
      indent(lv) + content_tag args, &block
    end

    def indent(lv)
      "\n" + lv * "\t"
    end  
  end
end