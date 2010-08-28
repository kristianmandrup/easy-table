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