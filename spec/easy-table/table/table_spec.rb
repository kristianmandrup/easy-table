require 'spec_helper'  

require 'sugar-high/includes'
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
                             
  describe '#table' do
    it 'should display a table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table posts, %w{id title} do |post| %>
            <%= data_row post, %w{id title} %>
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /<tr>/
        res.should match /<td>1<\/td>/
        res.should match /<td>my post<\/td>/
        # puts res        
      end
    end

    it 'should display a blank table' do
      with_engine(:erb) do |e|        
        res = e.run_template_locals :posts => @posts do %{
          <%= table posts, %w{id title} do %>
            hello
          <% end %>
        }
        end      
        res.should match /<table>/
        res.should match /hello/
        # puts res        
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