module EasyTable::ViewExt::Table
  module Util
    def set_options! options={}
      options.reverse_merge!({
        :placeholder  => options[:placeholder] || 'Nothing to display',
        :caption      => nil,
        :summary      => nil,
        :footer       => '',
        :table_class  => obj_type
      })           
    end  
    
    def get_obj_type collection
      collection.first.class.to_s      
    end    
  end
end