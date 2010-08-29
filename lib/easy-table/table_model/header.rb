module EasyTable::Model
  class Header
    attr_reader :table, :header_row
        
    def initialize table, options = {}, &block
      super table, options      
      @header_row = render_list
      if block
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
      end      
    end        

    def render
      header_row.render
    end
    
    module Row
      def row object, options = {}, &block
        @header_row = build_row object, options, &block
      end
    
      protected

      def build_row object, options = {}, &block
        EasyTable::Model::Row.new object, options, &block
      end
    end    

  end
end
