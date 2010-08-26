module EasyTable::ViewExt::Row
  module Data
    def data_rows collection, attributes, options = {}
      content = []
      reset_cycle('rows')
      collection.each do |obj|                        
        row_content = data_row(obj, attributes, options)        
        content << indent(2) + row_content
      end      
      content.join.html_safe
    end

    def data_row object, attributes, options={}            
      row_content = attribute_cells object, attributes, options.clone

      cls_opt = class_option(:row_classes, options, :name => 'rows')
      options[:row] ||= {}
      options[:row].merge!(cls_opt)
      
      indent_tag(2, :tr, row_content, options[:row]).html_safe
    end
    
    def attribute_cells object, attributes, options = {}
      options.delete(:row_classes)
      content = []
      reset_cycle('cells')      
      attributes.each do |attrib|
        cls_opt = class_option(:cell_classes, options, :name => 'cells')
        
        content << cell(object, attrib, options.merge(cls_opt))
        content << ''.indent(2) if attrib == attributes.last
      end
      content.join.html_safe
    end
  end
end