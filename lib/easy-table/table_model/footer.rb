module EasyTable::Model
  class Footer
    include EasyTable::Tags::Footer

    attr_reader :subtitle
        
    def initialize table, subtitle, options = {}
      super table, options
      @subtitle = subtitle
    end        
    
    def render
      footer_tag subtitle, table.header_list.size
    end
  end
end
