require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'
require 'easy-table/cell'

describe EasyTable::ViewExt::Cell do
  extend_view_with EasyTable::ViewExt, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
  end

  describe '#cell' do
    it 'should display a cell with the post title' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= cell post, :title %>
        }
        end
        res.should match(/<td>my post<\/td>/)
      end
    end

    it 'should display a cell with a class' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= cell post, :title, :class => 'posting' %>
        }
        end
        res.should match(/<td class="posting">my post<\/td>/)
      end
    end
  end
    
  describe '#cells' do
    it 'should display cells for post' do
      with_engine do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= cells post, %w{id title} %>
        }
        end
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end
  
    it 'should display cells for post with classes' do
      with_engine do |e|              
        res = e.run_template_locals :post => @post do %{
          <%= cells post, %w{id title}, :classes => %w{red blue} %>
        }
        end
        res.should match /<td class="red">1<\/td>/
        res.should match /<td class="blue">my post<\/td>/
      end
    end
  end

  describe '#headers' do
    it 'should display header cells' do
      with_engine do |e|        
        res = e.run_template do %{
          <%= header_row %w{Id Title} %>
        }
        end
        res.should match /<th>Id<\/th>/
        res.should match /<th>Title<\/th>/
      end
    end
  end

end


