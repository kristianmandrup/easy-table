require 'require_all'
require_all File.dirname(__FILE__) + '/row'
require 'easy-table/cell'

module EasyTable::ViewExt
  module Row
    def render_header heads
      return nil if heads.empty?

      indent_tag 1, :thead do
        indent_tag 2, :tr do 
          header_row heads          
        end.indent 1
      end.html_safe  
    end

    def render_footer footer, headers             
      size = case headers
      when Fixnum
        headers
      when Array
        headers.size
      else
        raise ArgumentError, "Must take a 2nd argument that indicates number of columns the footer should span"
      end
      return nil if footer.blank?
      indent_tag 1, :tfoot do
        indent_tag 2, :tr do      
          indent_tag(3, :th, footer, :colspan => size).indent 2
        end.indent(1)
      end.html_safe
    end
  
    def row object, options={}, &block
      content = with_output_buffer { yield object }
      indent_tag(2, :tr, content, options).html_safe
    end
    
    includes :data
  end
end