require 'spec_helper'  

describe EasyTable::ViewExt::Table::Base do
  extend_view_with EasyTable::ViewExt, :table, :row, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end
                             
  describe '#table' do
    it 'should display a table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table_for posts, :columns => %w{id title} do |tbl| %>
            <%= tbl.rows %>
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /<tbody>/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res        
      end
    end
    
    it 'should display a table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table_for posts, :columns => %w{id title} do |tbl| %>
            <%= tbl.body :class => 'red' do |body| %>
              <%= body.rows %>
            <% end %>   
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /<tbody class="red">/        
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res        
      end
    end
        
    it 'should display a table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table_for posts, :columns => %w{id title} do |tbl| %>
            <%= tbl.body :class => 'yellow' do |body| %>
              <%= body.rows :classes => %w{gray white} do |row| %>
                <%= row.cells :classes => %w{red blue} %> 
            <% end %>   
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /<tbody class="yellow">/        
        res.should match /<tr class="white">/
        res.should match /<tr class="gray">/
        res.should match /<td class="red">1<\/td>/
        res.should match /<td class="blue">my post<\/td>/
        # puts res        
      end
    end    
  end
end    
    