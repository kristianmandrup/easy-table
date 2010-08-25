require 'spec_helper'  
require 'easy-table/namespaces'
require 'easy-table/util'

describe EasyTable::ViewExt::Util do
  setup_action_view do
    tests EasyTable::ViewExt::Util
  end

  describe '#cycle' do
    it 'should cycle classes' do
      with_action_view do |view| 
        res1 = view.cycle("a", "b")
        res2 = view.cycle("a", "b")
        puts "#{res1}, #{res2}"
      end
    end
  end

  describe '#get_classes' do
    it 'should display classes' do
      with_action_view do |view| 
        res1 = view.get_classes :a, :b
        res2 = view.get_classes :a, :b
        puts "#{res1}, #{res2}"
      end
    end
  end

end