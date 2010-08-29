module EasyTable::Model
  class Body
    attr_reader :row_list

    def initialize table, &block
      super table
      @row_list = render_list
      if block
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
      end
    end

    def render
      body_tag options do
        row_list.render
      end
    end

    # DRY up! Same in Table
    module Row
      def row object, options = {}, &block
        @row_list << build_row object, options, &block
      end
    
      def rows collection, options = {}, &block        
        collection.each{|item| row item, options, &block }
      end

      protected

      def build_row object, options = {}, &block
        EasyTable::Model::Row.new object, options, &block
      end
    end    
  end
end
