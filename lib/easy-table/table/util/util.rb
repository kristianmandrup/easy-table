require 'sugar-high/blank'
require 'sugar-high/array'
require 'sugar-high/arguments'

module EasyTable::ViewExt
  module Util
    def class_option id, options, cycle_options={}
      return {} if !options[id]
      {:class => get_class(options[id], :name => cycle_options[:name] || nil) }
    end    
    
    def get_class *classes
      options = last_option classes
      return cycle_class(options[:name]) if classes.blank?        

      classes = [classes].flatten
      name = options[:name]

      return cycle(*classes, :name => name) if name
      cycle(*classes)
    end

    def cycle_class name=nil
      name ? cycle('odd', 'even', :name => name) : cycle('odd', 'even')
    end
  end
end