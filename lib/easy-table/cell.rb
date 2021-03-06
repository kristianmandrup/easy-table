require 'easy-table/util'
require 'easy-table/tag'

module EasyTable::ViewExt
  module Cell
    def header_row heads
      content = []
      heads.each do |head| 
        content << indent_tag(3, :th, head)
        content << ''.indent(2) if head == heads.last        
      end
      content.join.html_safe
    end
    
    def cells object, attributes, options = {}
      content = []            
      reset_cycle('cells')
      attributes.each_with_index do |attrib, index|    
        cls_opt = class_option(:classes, options, :name => 'cells')
        
        content << cell(object, attrib, options.merge(cls_opt))
        content << ''.indent(2) if attrib == attributes.last
      end
      content.join.html_safe
    end

    def cell object, attribute, options = {} 
      options.delete(:classes)
      options.delete(:cell_classes)
      options.delete(:row_classes)
      options.delete(:row)
      value = object.send(attribute) || "Unknown attribute: #{attribute}"
      indent_tag(3, :td, value, options).html_safe
    end  
    
    include EasyTable::ViewExt::Util    
  end
end