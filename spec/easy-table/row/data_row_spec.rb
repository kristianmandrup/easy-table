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
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end

  describe '#data_row' do
    it 'should display a row with data' do
      with_action_view do |view|             
        res = view.data_row @post, %w{id title}
        puts res
      end
    end

    it 'should display a row with data and row class' do
      with_action_view do |view|             
        res = view.data_row @post, %w{id title}, :row => {:class => 'my_data_row'}
        puts res
      end
    end

    it 'should display a row with data' do
      with_action_view do |view|             
        res = view.data_row @post, %w{id title}, :row => {:class => 'my_data_row'}, :cell_classes => %w{number label}
        puts res
      end
    end
  end

  describe '#data_rows' do    
    it 'should display a row with cells' do
      with_action_view do |view| 
  
        res = view.data_rows @posts, %w{id title}
        puts res
      end
    end
  
    it 'should display a row with cells with cycling classes' do
      with_action_view do |view| 
        res = view.data_rows @posts, %w{id title}, :row_classes => %w{row1 row2}
        puts res
      end
    end
  end
end


