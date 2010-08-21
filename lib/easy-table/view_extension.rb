module EasyTable
  module ViewExtension
    def table(collection, headers, options = {}, &proc)
      obj_type = collection.first.class.to_s

      options.reverse_merge!({
        :placeholder  => 'Nothing to display',
        :caption      => nil,
        :summary      => nil,
        :footer       => ''
        :table_class  => obj_type
      })           
    
      unless collection.any?
        content = with_output_buffer(&block)
        content = placeholder 
        return content
      end

      content_tag :table, :class => options[:table_class], :summary => summary do
        render_caption options[:caption]            
        render_header headers
        render_footer options[:footer]  
        render_tbody collection, &block       
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

    def rows collection, attributes, clazz, &block
      collection.each do |obj|                  
        row_content = data_row(obj, attributes, row_class)
        content << indent(2) + row_content
      end      
    end

    def row_class 
      cycle('odd', 'even')
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
        cell object, attrib, cycle(classes) if classes.any?
      end
    end
  
    def cell object, attribute, clazz=nil
      value = object.send attribute if object.respond_to? attribute
      do_tag 3, :td, :class => clazz, value || "Unknown attribute: #{attribute}"
    end
  
    def do_tag lv, *args, &block        
      indent(lv) + content_tag args, &block
    end

    def indent(lv)
      "\n" + lv * "\t"
    end  
  end
end