require 'spec_helper'  
require 'easy-table/namespaces'
require 'easy-table/tag'

describe EasyTable::ViewExt::Tag do
  setup_action_view do
    tests EasyTable::ViewExt::Tag
  end

  describe '#do_tag' do
    it 'should display an tag with NO indent' do
      with_action_view do |view| 
        res = view.do_tag :li, :class => 'mine' do
          'hello'
        end        
        puts res
      end
    end
  end

  describe '#indent_tag' do
    it 'should display a 2*2 space indented tag' do
      with_action_view do |view| 
        res = view.indent_tag 2,:li, :class => 'mine' do
          'hello'
        end        
        puts res
      end
    end
  end

end