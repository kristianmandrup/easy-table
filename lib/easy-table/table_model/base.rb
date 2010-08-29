module EasyTable
  module Model
    class Base
      attr_reader :table, :options
    
      def initialize table, options
        @table, @options = table, options
      end 
    
      protected

      def render_list
        [].extend EasyTable::Renderer
      end
    end
  end

  module Renderer
    def render
      each{|item| item.render }
    end    
  end
end
