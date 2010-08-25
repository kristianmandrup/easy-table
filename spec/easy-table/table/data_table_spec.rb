require 'spec_helper'  

require 'sugar-high/includes'
require 'sugar-high/blank'

require 'easy-table/namespaces'

require 'easy-table/table'
require 'easy-table/row'

describe EasyTable::ViewExt::Table::Base do
  setup_action_view do
    tests EasyTable::ViewExt::Table, EasyTable::ViewExt::Row, EasyTable::ViewExt::Cell, EasyTable::ViewExt::Tag
  end

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end
                             
  describe '#data_table' do
    it 'should display a table caption' do
      with_action_view do |view|             
        res = view.data_table @posts, %w{Id Title}, :summary => 'many posts', :caption => 'posts table'
        puts res
      end
    end
  end
end