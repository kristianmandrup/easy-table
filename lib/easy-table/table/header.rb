module EasyTable::ViewExt::Table
  module Header
    def header_row heads
      content = []
      heads.each do |head| 
        content << indent_tag(3, :th, head)
        content << ''.indent(2) if head == heads.last        
      end
      content.join.html_safe
    end

    def render_header heads
      return nil if heads.empty?

      indent_tag 1, :thead do
        indent_tag 2, :tr do 
          header_row heads          
        end.indent 1
      end.html_safe  
    end
  end
end