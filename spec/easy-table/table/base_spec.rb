require 'spec_helper'  

require 'sugar-high/includes'
require 'easy-table/namespaces'

require 'easy-table/table'

describe EasyTable::ViewExt::Table::Base do
  extend_view_with EasyTable::ViewExt, :table, :row, :cell, :tag

  before :each do
    @post = stub(:title => 'my post', :id => 1, :author => 'kristian' )
    @post2 = stub(:title => 'my other post', :id => 2, :author => 'mike' )
    
    @posts = [@post, @post2]
  end
                             
  describe '#render_caption' do
    it 'should display a table caption' do
      with_engine(:erb) do |e|        
        res = e.run_template do %{
          <%= render_caption 'my caption' %>
        }
        end      
        res.should match /<caption>my caption<\/caption>/
      end
    end
  end

  describe '#table_body' do
    it 'should display a table body with rows' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table_body posts do |post| %>
            <%= data_row post, %w{id title} %>
          <% end %>
        }
        end
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res
      end
    end
  end
  
  describe '#render_tbody' do
    it 'should display a table body' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= render_tbody posts do |post| %>
            <%= data_row post, %w{id title} %>
          <% end %>
        }
        end      
        res.should match /<tbody>/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res
      end
    end
  end

  describe '#render_table' do
    it 'should display a table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= render_table do %>
            <%= render_tbody posts do |post| %>
              <%= data_row post, %w{id title} %>
            <% end %>  
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /<tbody>/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
      end
    end

    it 'should display a blank table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= render_table do %>
            hello
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /hello/
        puts res        
      end
    end
  
    it 'should display a table with attributes' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= render_table :class => 'tables#posts', :id => 'posts_table' do %>
            <%= render_tbody posts do |post| %>
              <%= data_row post, %w{id title} %>
            <% end %>  
          <% end %>
        }
        end      
        res.should match /<table class="tables#posts" id="posts_table">/
        res.should match /<tbody>/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res
      end
    end
  end
end
