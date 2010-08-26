require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'
require 'easy-table/cell'
require 'easy-table/row'

describe EasyTable::ViewExt::Row do
  extend_view_with EasyTable::ViewExt, :row, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end

  describe '#attribute_cells' do
    it 'should display cells with data' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= attribute_cells post, %w{id title} %>
        }
        end                    
        res.should_not match /<tr>/        
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end
  end

  describe '#data_row' do
    it 'should display a row with data' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= data_row post, %w{id title} %>
        }
        end      
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end

    it 'should display a row with data and row class' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= data_row post, %w{id title}, :row => {:class => 'my_data_row'} %>
        }
        end      
        res.should match /<tr class="my_data_row">/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end
    
    it 'should display a row with data' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= data_row post, %w{id title}, :row => {:class => 'my_data_row'}, :cell_classes => %w{number label} %>
        }
        end      
        res.should match /<tr class="my_data_row">/
        res.should match /<td class="number">1<\/td>/
        res.should match /<td class="label">my post<\/td>/
      end
    end
  end

  describe '#data_rows' do    
    it 'should display a row with cells' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= data_rows posts, %w{id title} %>
        }
        end      
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        res.should match /<td>2<\/td>/
        res.should match /<td>my other post<\/td>/
      end
    end
  
    it 'should display a row with cells with cycling classes' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= data_rows posts, %w{id title}, :row_classes => %w{row1 row2}, :cell_classes => %w{number label} %>
        }
        end      
        res.should match /<tr class="row1">/
        res.should match /<tr class="row2">/
        res.should match /<td class="number">1<\/td>/
        res.should match /<td class="label">my post<\/td>/
      end
    end
  end
end


