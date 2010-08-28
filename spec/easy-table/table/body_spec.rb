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