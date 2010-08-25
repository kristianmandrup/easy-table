require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'
require 'easy-table/cell'
require 'easy-table/row'

describe EasyTable::ViewExt::Row do
  setup_action_view do
    tests EasyTable::ViewExt::Row, EasyTable::ViewExt::Cell, EasyTable::ViewExt::Tag
  end

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
  end

  describe '#row' do
    it 'should display a row with cells' do
      with_action_view do |view| 
        res = view.row @post, :class => :mine do |post|
          view.cells post, %w{id title}
        end
        puts res
      end
    end

    it 'should display a row with cells with cycling classes' do
      with_action_view do |view| 
        res = view.row @post, :class => :mine do |post|
          view.cells post, %w{id title}, %w{number label}
        end
        puts res
      end
    end
  end

  describe '#render_header' do
    it 'should display a header with header cells' do
      with_action_view do |view| 
        res = view.render_header %w{id title} do
        end
        puts res
      end
    end
  end
  
  describe '#render_footer' do
    it 'should display a footer spanning the length of the header' do
      with_action_view do |view| 
        res = view.render_footer 'a nice table', %w{id title}
        puts res
      end
    end
  end
end
