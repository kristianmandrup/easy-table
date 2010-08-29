module EasyTable::Model
  class Row
    attr_reader :cell_list
    
    def initialize table, object, options = {}, &block
      super table, options
      @cell_list = render_list
      if block
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
      end
      render
    end

    def render
      row_tag options do
        cell_list.render
      end
    end

    # DRY up! Same in Table
    module Cell
      def cell object, options={}, &block
        @cell_list << build_cell object, options, &block
      end
    
      def cells collection, options={}, &block
        collection.each{|item| cell item, options, &block }
      end
      
      protected 
      
      def build_cell object, options = {}, &block
        EasyTable::Model::Cell.new table, object, options, &block
      end      
    end    
  end
end
