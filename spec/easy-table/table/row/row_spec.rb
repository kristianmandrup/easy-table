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
end
