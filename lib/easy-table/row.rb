require 'require_all'
require_all File.dirname(__FILE__) + '/row'

module EasyTable::ViewExt
  module Row
    def render_header heads
      return if !heads.any?

      indent_tag 1, :thead do
        indent_tag 2, :tr do 
          headers heads          
        end.indent 1
      end  
    end

    def render_footer footer, headers
      return if !footer
      indent_tag 1, :foot do
        indent_tag 2, :tr do      
          indent_tag(3, :th, footer, :colspan => headers.size).indent 2
        end.indent(1)
      end
    end
  
    def row object, options={}, &block
      content = with_output_buffer { yield object }
      indent_tag 2, :tr, content.html_safe, options
    end
    
    includes :data
  end
end