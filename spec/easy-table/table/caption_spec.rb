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
