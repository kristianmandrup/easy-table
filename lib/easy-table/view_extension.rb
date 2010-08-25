require 'active_support/inflector'
require 'require_all'
require 'sugar-high/includes'
require 'easy-table/namespaces'

require 'easy-table/table'
require 'easy-table/row'
require 'easy-table/cell'
require 'easy-table/tag'

module EasyTable
  module ViewExt
    includes :table, :row, :cell, :tag
  end
end
