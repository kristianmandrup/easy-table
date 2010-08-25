require 'sugar-high/blank'
require 'sugar-high/array'

module EasyTable::ViewExt
  module Util
    def class_option sym, options=nil
      return {} if !options[sym]
      {:class => get_class(options[sym]) }
    end    
    
    def get_class *classes
      classes.any? ? cycle(*classes.flatten) : cycle_class
    end

    def cycle_class 
      cycle('odd', 'even')
    end
  end
end