require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'

require 'easy-table/table'

describe EasyTable::ViewExt::Table::Base do
  setup_action_view do
    tests EasyTable::ViewExt::Table, EasyTable::ViewExt::Row, EasyTable::ViewExt::Cell, EasyTable::ViewExt::Tag
  end

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end
                             
  describe '#render_caption' do
    it 'should display a table caption' do
      with_action_view do |view|             
        res = view.render_caption 'my caption'
        puts res
      end
    end
  end

  describe '#table_body' do
    it 'should display a table body with rows' do
      with_action_view do |view|             
        res = view.table_body @posts do |post|
          view.data_row post, %w{id title}
        end
        puts res
      end
    end
  end
  
  describe '#render_tbody' do
    it 'should display a table body' do
      with_action_view do |view|             
        res = view.render_tbody @posts do |post|
          view.data_row post, %w{id title}
        end
        puts res
      end
    end
  end

  describe '#render_table' do
    it 'should display a table' do
      with_action_view do |view|             
        res = view.render_table do
          view.render_tbody @posts do |post|
            view.data_row post, %w{id title}
          end
        end
        puts res
      end
    end

    it 'should display a table with attributes' do
      with_action_view do |view|             
        res = view.render_table :class => 'tables#posts', :id => 'posts_table' do
          'hello'
        end
        puts res
      end
    end
  end
end
