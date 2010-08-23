require 'spec_helper'
require 'easy-table/view_extension'

module EasyTable
  module ViewExtension    
    def set attributes={}
      attributes.each do |key, value|
        instance_var = "@#{key}"
        instance_variable_set(instance_var, value)
      end
    end      
  end
end

describe EasyTable do
  setup_action_view do
    tests EasyTable::ViewExtension
  end

  before :each do
    post1 = stub(:id => 1, :title => 'My post')
    post2 = stub(:id => 2, :title => 'My other post')
    @posts = [post, post]   
  end

  # it 'should render table using #table helper' do        
  #   with_action_view do |view|
  #     view.set :@posts => @posts
  #     
  #     result = view.with_template do %{      
  #       <% table @posts, %w{ID title} do |post, klass| -%>
  #           <tr class="<%= klass %>">
  #             <td><%= post.id</td>
  #             <td><%= post.title </td>
  #           </tr>
  #       <% end -%>}
  #     end  
  #     puts result
  #   end    
  # end
  # 
  # it 'should render table using #row helper' do        
  #   with_action_view do |view|               
  #     result = view.with_template do %{            
  #       <% table(@posts, %w{ID title}) do |post, klass| -%>
  #           <% row klass do |post| -%>
  #             <td><%= post.id %></td>
  #             <td><%= post.title %></td>
  #           <% end -%>
  #       <% end -%>}
  #     end
  #     puts result      
  #   end    
  # end

  # it 'render table using #row and #cell helpers' do        
  #   with_action_view do |view|
  #     result = view.with_template do %{
  #       <% table(@posts, %w{ID title}) do |post, klass| -%>
  #           <% row klass do |post| -%>
  #             <%= cell post.id %>
  #             <%= cell post.title %>
  #           <% end -%>
  #       <% end -%>
  #     }
  #     end
  #     puts result
  #   end
  # end
  # 
  # it 'render table using #data_row helper' do        
  #   with_action_view do |view|
  #     result = view.with_template do %{
  #       <% table(@posts, %w{ID title}) do |post, klass| -%>
  #           <% data_row post, %w{id title}, klass -%>
  #       <% end -%>  
  #     }
  #     end
  #     puts result
  #   end
  # end
  # 
  # it 'render table using #cells helper' do        
  #   with_action_view do |view|
  #     result = view.with_template do %{
  #       <% table(@posts, %w{ID title}) do |post, klass| -%>
  #           <% row klass do |post| -%>
  #             <%= cells post, %w{id title}, %w{number label} %>
  #           <% end -%>
  #       <% end -%>  
  #     }
  #     end
  #     puts result
  #   end
  # end
  # 
  # it 'render table using #rows helper' do        
  #   with_action_view do |view|
  #     result = view.with_template do %{
  #       <% render_table 'posts', 'Posts table', do -%>
  #           <% rows @posts, klass, :id, :title -%>
  #       <% end -%>  
  #     }
  #     end
  #     puts result
  #   end
  # end
end
