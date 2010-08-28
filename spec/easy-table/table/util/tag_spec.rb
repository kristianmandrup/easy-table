require 'spec_helper'  
require 'easy-table/namespaces'
require 'easy-table/tag'

describe EasyTable::ViewExt::Tag do
  extend_view_with EasyTable::ViewExt::Tag

  describe '#do_tag' do
    it 'should display an tag with NO indent' do
      with_engine(:erb) do |e|
        res = e.run_template do %{
          <%= do_tag :li, :class => 'mine' do %>
            hello
          <% end %>
        }
        end
        res.should match(/mine/)
        res.should match(/hello/)      
      end
    end
  end

  describe '#indent_tag' do
    it 'should display a 2*2 space indented tag' do
      with_engine(:erb) do |e|
        res = e.run_template do %{
          <%= indent_tag 2,:li, :class => 'mine' do %>
            hello
          <% end %>
        }
        end
        # should make 4 spaces after new line!
        res.should match(/\n\s{4}<li/)
        puts res
      end
    end
  end
end