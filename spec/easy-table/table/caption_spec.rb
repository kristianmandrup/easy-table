require 'spec_helper'

describe EasyTable::ViewExt::Table::Caption do
  extend_view_with EasyTable::ViewExt::Table, :caption
  extend_view_with EasyTable::ViewExt, :tag

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
end