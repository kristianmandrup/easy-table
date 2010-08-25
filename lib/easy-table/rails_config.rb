require 'rails3_plugin_toolbox'

Rails3::PluginExtender.new do
  extend_rails :view do
    with EasyTable::ViewExt
  end
end  
