module EasyTable::ViewExt::Table
  module Caption
    def render_caption caption
      indent_tag(1, :caption, caption) if !caption.blank?
    end
  end
end