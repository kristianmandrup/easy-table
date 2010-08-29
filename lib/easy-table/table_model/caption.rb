module EasyTable::Model
  class Caption
    include EasyTable::Tags::Caption

    attr_reader :title
        
    def initialize table, title, options = {}
      super table, options
      @title = title
    end        
    
    def render
      caption_tag title
    end
  end
end
