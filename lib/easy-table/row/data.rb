module EasyTable::ViewExt::Row
  module Data
    def data_rows collection, attributes, options = {}
      content = []
      collection.each do |obj|                        
        cls_opt = class_option(:row_classes, options)
        row_content = data_row(obj, attributes, options.merge(cls_opt))
        
        content << indent(2) + row_content
      end      
      content.join
    end

    def data_row object, attributes, options={}
      row object, options[:row] do
        attribute_cells object, attributes, options        
      end
    end
    
    def attribute_cells object, attributes, options = {}
      content = []
      attributes.each do |attrib|
        cls_opt = class_option(:cell_classes, options)
        
        content << cell(object, attrib, options.merge(cls_opt))
        content << ''.indent(2) if attrib == attributes.last                
      end
      content.join
    end
  end
end