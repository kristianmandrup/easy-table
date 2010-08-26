require 'spec_helper'  
require 'easy-table/namespaces'
require 'easy-table/util'

describe EasyTable::ViewExt::Util do
  extend_view_with EasyTable::ViewExt::Util

  describe '#cycle' do
    it 'should cycle classes' do
      with_engine(:erb) do |e|
        res = e.run_template_locals :options => {:row_classes => %w{class1 class2}} do %{
          <%= class_option :row_classes, options %>
          <%= class_option :row_classes, options %>
        }
        end
        res.should match(/class1/)
        res.should match(/class2/)      
      end
      
    end
  end



  describe '#cycle' do
    it 'should cycle classes' do
      with_engine(:erb) do |e|
        res = e.run_template_locals :classes => ["abc", "def"] do %{
          <%= cycle("abc", "def") %>
          <%= cycle("abc", "def") %>
          <%= cycle(*classes) %>
          <%= cycle(*classes) %>
        }
        end
        res.should match(/abc/)
        res.should match(/def/)
        # puts res      
      end
    end
  end

  describe '#get_class' do
    it 'should cycle classes' do
      with_engine(:erb) do |e|
        res = e.run_template do %{
          <%= get_class("abc", "def") %>
          <%= get_class("abc", "def") %>
        }
        end
        res.should match(/abc/)
        res.should match(/def/)      
      end
    end

    it 'should default to odd/even classes when no args' do
      with_engine(:erb) do |e|
        res = e.run_template do %{
          <%= get_class %>
          <%= get_class %>
        }
        end
        res.should match(/odd/)
        res.should match(/even/)      
      end
    end
  end
end