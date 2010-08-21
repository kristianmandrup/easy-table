require 'rails3_plugin_toolbox'

module EasyTable::Configure
  module Rails
    class << self
      include Rails::Plugin::Toolbox::Extender

      def do!
        # extend action_view with methods from some modules
        extend_rails(:view) do
          with EasyTable::ViewExtension
        end
      end    
    end
  end                          
end

EasyTable::Configure::Rails.do!