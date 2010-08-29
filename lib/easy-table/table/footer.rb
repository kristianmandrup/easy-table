module EasyTable::ViewExt::Table
  module Footer
    def footer footer, headers             
      return nil if footer.blank?
      indent_tag 1, :tfoot do
        indent_tag 2, :tr do      
          indent_tag(3, :th, footer, :colspan => size(headers)).indent 2
        end.indent(1)
      end.html_safe
    end
    
    protected

    def size headers
      case headers
      when Fixnum
        headers
      when Array
        headers.size
      else
        raise ArgumentError, "Must take a 2nd argument that indicates number of columns the footer should span"
      end
    end    
  end
end