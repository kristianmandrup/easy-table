require 'sugar-high/blank'
require 'sugar-high/array'

module EasyTable::ViewExt
  module Util
    def class_option id, options, name=nil
      return {} if !options[id]
      {:class => get_class(options[id], name) }
    end    
    
    def get_class classes, name = 'default'
      return cycle_class if classes.empty?
      classes = classes.flatten
      classes.any? ? cycle(*classes, :name => name) : cycle_class(name)
    end

    def cycle_class name=nil
      name ? cycle('odd', 'even', :name => name) : cycle('odd', 'even')
    end
  end
end