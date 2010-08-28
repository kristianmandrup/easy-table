module EasyTable::ViewExt::Table
  module Header
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
  end
end