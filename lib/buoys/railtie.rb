# frozen_string_literal: true

module Buoys
  class Railtie < ::Rails::Railtie
    initializer 'buoys' do
      ActiveSupport.on_load(:action_view) do
        ActionView::Base.include Buoys::Helper
      end
    end
  end
end
