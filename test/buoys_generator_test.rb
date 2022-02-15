# frozen_string_literal: true

# rubocop:disable Style/RegexpLiteral, Layout/LineLength
require 'test_helper'
require 'generators/buoys/install_generator'

class BuoysGeneratorTest < Rails::Generators::TestCase
  tests ::Buoys::InstallGenerator
  destination dest_root = File.expand_path('./generator_root', File.dirname(__FILE__))

  Minitest.after_run do
    FileUtils.rm_rf(Dir.glob("#{dest_root}/**"))
  end

  test 'no template option' do
    run_generator

    assert_file File.expand_path('./app/views/breadcrumbs/_buoys.html.erb', dest_root) do |content|
      assert_match %r|itemscope itemtype='http://schema.org/BreadcrumbList'|, content
      assert_match %r|<li itemprop='itemListElement' itemscope itemtype='http://schema.org/ListItem'>|, content
      assert_match %r|<span itemprop='name'>|, content
      assert_match %r|<meta itemprop='position' content='<%= i %>' />|, content
    end
    assert_file File.expand_path('./config/buoys/breadcrumbs.rb', dest_root)
    assert_file File.expand_path('./config/locales/buoys.en.yml', dest_root)
  end

  test 'option --template haml' do
    run_generator %w(--template haml)

    assert_file File.expand_path('./app/views/breadcrumbs/_buoys.html.haml', dest_root) do |content|
      assert_match %r|%ol.breadcrumb{itemscope: true, itemtype: 'http://schema.org/BreadcrumbList'}|, content
      assert_match %r|%li{itemprop: 'itemListElement', itemscope: true, itemtype: 'http://schema.org/ListItem'}|, content
      assert_match %r|%span{itemprop: 'name'}=|, content
      assert_match %r|%meta{itemprop: 'position', content: i}|, content
    end
    assert_file File.expand_path('./config/buoys/breadcrumbs.rb', dest_root)
    assert_file File.expand_path('./config/locales/buoys.en.yml', dest_root)
  end

  test 'option --template slim' do
    run_generator %w(--template slim)

    assert_file File.expand_path('./app/views/breadcrumbs/_buoys.html.slim', dest_root) do |content|
      assert_match %r|ol.breadcrumb itemscope=true itemtype='http://schema.org/BreadcrumbList'|, content
      assert_match %r|li itemprop='itemListElement' itemscope=true itemtype='http://schema.org/ListItem'|, content
      assert_match %r|span itemprop='name'|, content
      assert_match %r|meta itemprop='position' content=i|, content
    end
    assert_file File.expand_path('./config/buoys/breadcrumbs.rb', dest_root)
    assert_file File.expand_path('./config/locales/buoys.en.yml', dest_root)
  end
end
# rubocop:enable Style/RegexpLiteral, Layout/LineLength
