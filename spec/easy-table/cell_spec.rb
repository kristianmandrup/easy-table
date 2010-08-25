require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'
require 'easy-table/cell'

describe EasyTable::ViewExt::Cell do
  setup_action_view do
    tests EasyTable::ViewExt::Cell, EasyTable::ViewExt::Tag
  end

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
  end

  describe '#cell' do
    it 'should display a cell' do
      with_action_view do |view| 
        res = view.cell @post, :title
        puts res
      end
    end

    it 'should display a cell with a class' do
      with_action_view do |view| 
        res = view.cell @post, :title, :my_class
        puts res
      end
    end
  end


  describe '#cells' do
    it 'should display cells for post' do
      with_action_view do |view|         
        res = view.cells @post, %w{id title}
        puts res
      end
    end

    it 'should display cells for post with classes' do
      with_action_view do |view| 
        res = view.cells @post, %w{id title}, %w{number label}
        puts res
      end
    end
  end

end


