require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'
require 'easy-table/row'

describe EasyTable::ViewExt::Row do
  extend_view_with EasyTable::ViewExt, :row, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
  end

  describe '#row' do
    it 'should display a cell with the post title' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= row post, :class => :mine do |post| %>
            <%= cells post, %w{id title} %>
          <% end %>
        }
        end      
        res.should match /<tr class="mine">/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end
  end
  
  describe '#render_header' do
    it 'should display a header with header cells' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= render_header %w{Id Title} %>
        }
        end      
        res.should match /<thead>/
        res.should match /<tr>/
        res.should match /<th>Id<\/th>/
        res.should match /<th>Title<\/th>/
      end
    end
  end
  
  describe '#render_footer' do
    it 'should display a footer spanning the length of the header' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= render_footer 'a nice table', %w{id title} %>
        }
        end      
        res.should match /<tfoot>/
        res.should match /colspan="2"/
      end
    end

    it 'should display a footer spanning 2 cells' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :post => @post do %{
          <%= render_footer 'a nice table', 2%>
        }
        end      
        res.should match /<tfoot>/    
        res.should match /colspan="2"/        
      end
    end
  end
end
