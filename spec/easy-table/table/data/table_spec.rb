require 'spec_helper'  

require 'sugar-high/includes'
require 'sugar-high/blank'

require 'easy-table/namespaces'

require 'easy-table/table'
require 'easy-table/row'

describe EasyTable::ViewExt::Table::Base do
  extend_view_with EasyTable::ViewExt, :table, :row, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end
                             
  describe '#data_table' do
    it 'should display a data table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= data_table posts, %w{Id Title}, :summary => 'many posts', :caption => 'posts table' %>
        }
        end      
        res.should match /<table summary="many posts">/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        puts res
      end
    end
  end
end