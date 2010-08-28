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
