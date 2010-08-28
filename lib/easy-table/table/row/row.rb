require 'require_all'
require_all File.dirname(__FILE__) + '/row'
require 'easy-table/cell'

module EasyTable::ViewExt
  module Row  
    def row object, options={}, &block
      content = with_output_buffer { yield object }
      indent_tag(2, :tr, content, options).html_safe
    end
    
    includes :data
  end
end