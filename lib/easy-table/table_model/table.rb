module EasyTable::Model
  class Table
    attr_reader :body_obj, :header_obj, :footer_obj, :caption_title
    
    def initialize &block
      if block
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
      end      
    end

    module Caption
      include EasyTable::Tags::Caption
      
      def caption title, options={}
        @caption_obj = build_caption title, options
        caption_obj.render
      end
      
      protected
      
      def build_caption title, options = {}
        EasyTable::Model::Footer.new self, title, options
      end      
    end

    module Header
      def header &block
        @header_obj = EasyTable::Model::Header.new &block
        header_obj.render
      end
    end

    module Footer
      def footer content, options = {}
        @footer_obj = build_footer content, options
        footer_obj.render
      end 

      protected
      
      def build_footer content, options = {}
        EasyTable::Model::Footer.new self, content, options
      end
    end

    module Body
      def body &block
        @body_obj = 
        body_obj.render
      end
      
      protected
      
      def build_body content
        EasyTable::Model::Body.new self, &block
      end      
    end

    module Row
      def row object, options={}, &block
        if !body_obj
          return body { row object, options, &block }            
        end
        body_obj.row object, options, &block
      end
    
      def rows collection, options = {}, &block        
        collection.each{|item| row item, options, &block }
      end
    end
    
    includes :caption, :header, :footer, :body, :row
  end
end