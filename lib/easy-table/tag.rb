module EasyTable::ViewExt
  module Tag
    def indent_tag lv, *args, &block
      (indent(lv) + content_tag(*args, &block)).html_safe
    end

    def do_tag *args, &block
      indent_tag 0, *args, &block
    end

    def indent(lv)
      "\n" + ("  " * lv)
    end
  end
end

class String
  def indent lv
    self << "\n" + ("  " * lv)
  end
end