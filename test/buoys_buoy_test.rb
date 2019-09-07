# frozen_string_literal: true

require 'test_helper'

class BuoysBuoyTest < ActiveSupport::TestCase
  setup do
    @view_context = if ActionView::Base.respond_to?(:empty)
                      ActionView::Base.empty
                    else
                      ActionView::Base.new # Rails 5.2 or lower
                    end
    Buoys::Loader.load_buoys_files
  end

  test 'can interpret multiple `link`s in one buoy block with argument' do
    links = Buoys::Buoy.new(@view_context, :help, true).links

    assert_equal links.size, 2
    assert_equal links[0].text, 'help'
    assert_equal links[0].url,  'https://example.com/help'
    assert_equal links[1].text, 'usage'
    assert_equal links[1].url,  'https://example.com/help/usage'

    links = Buoys::Buoy.new(@view_context, :help, false).links

    assert_equal links[0].url,  'http://example.com/help'
    assert_equal links[1].url,  'http://example.com/help/usage'
  end

  test 'can use :symbol as link name' do
    links = Buoys::Buoy.new(@view_context, :account).links

    assert_equal links[0].text, 'Account'
    assert_equal links[0].url,  'http://example.com/account'
  end
end
