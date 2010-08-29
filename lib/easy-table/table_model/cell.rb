module EasyTable::Model
  class Cell < EasyTable::Model::Base
    attr_reader :table
    
    def initialize table, object, options = {}, &block
      super table
      render
    end

    # message is usually an attribute on the object
    def render
      cell_tag object, message, options 
    end
  end
end
