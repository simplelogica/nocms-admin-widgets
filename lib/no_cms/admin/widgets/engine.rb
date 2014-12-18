require 'nocms-widgets'
require 'nocms-admin'
require 'jquery-rails'

module NoCms
  module Admin
    module  Widgets
      class Engine < ::Rails::Engine
        isolate_namespace NoCms::Admin::Widgets
      end
    end
  end
end
