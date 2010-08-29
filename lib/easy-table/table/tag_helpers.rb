module EasyTable::ViewExt::Table
  def caption_tag caption
    indent_tag(1, :caption, caption) if !caption.blank?
  end
  
  def tbody_tag collection, options={}, &block 
    indent_tag 1, :tbody do
      table_body(collection, options, &block).indent(1)
    end
  end  
end

