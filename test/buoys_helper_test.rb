# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
require 'test_helper'

class BuoysHelerTest < ActionView::TestCase
  include Buoys::Helper

  test '.buoy (only current)' do
    assert respond_to?(:breadcrumb)

    buoy :account
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal %(<ul><li><a class="active" href=""><span>Account</span></a></li></ul>), html
  end

  test '.buoy (not only active)' do
    buoy :history
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')
    expected_html =
      %(
        <ul>
          <li>
            <a class="hover" href="/about">
              <span>about</span>
            </a>
            <span>&gt;</span>
          </li>
          <li>
            <a class="active" href="">
              <span>history</span>
            </a>
          </li>
        </ul>
      ).gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal expected_html, html
  end

  test '.buoy (has 2 `link`s in one buoy block)' do
    breadcrumb :help, true
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')
    expected_html =
      %(
        <ul>
          <li>
            <a class="hover" href="https://example.com/help">
              <span>help</span>
            </a>
            <span>&gt;</span>
          </li>
          <li>
            <a class="active" href="">
              <span>usage</span>
            </a>
          </li>
        </ul>
      ).gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal expected_html, html
  end

  test '.buoy (receive multiple arguments)' do
    breadcrumb :edit_book_author, 1, 2
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')
    expected_html =
      %(
        <ul>
          <li>
            <a class="hover" href="http://example.com/books">
              <span>Books</span>
            </a>
            <span>&gt;</span>
          </li>
          <li>
            <a class="active" href="http://example.com/books/1/authors/2/edit">
              <span>edit-1-2</span>
            </a>
          </li>
        </ul>
      ).gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal expected_html, html
  end

  test '.buoy (use polymorphic routes)' do
    user = User.create(name: 'test user')
    item = Item.create(name: 'test item')

    breadcrumb :edit_user_item, [user, item]
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')
    expected_html =
      %(
        <ul>
          <li>
            <a class="hover" href="/users/#{user.id}/items/#{item.id}">
              <span>show user item</span>
            </a>
            <span>&gt;</span>
          </li>
          <li>
            <a class="active" href="/users/#{user.id}/items/#{item.id}/edit">
              <span>edit user item</span>
            </a>
          </li>
        </ul>
      ).gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal expected_html, html
  end

  test ".buoy (has configuration options in link's arguments)" do
    breadcrumb :show_books, 1
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')
    expected_html =
      %(
        <ul>
          <li>
            <a class="hover" href="http://example.com/books">
              <span>Books</span>
            </a>
            <span>&gt;</span>
          </li>
          <li>
            <a class="active" href="http://example.com/books/1">
              <span>show-1</span>
            </a>
          </li>
        </ul>
      ).gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal expected_html, html
  end

  test '.buoys (no given key)' do
    buoys
    html = render('breadcrumbs/buoys').gsub(/[[:space:]]{2,}|\n/, '')

    assert_dom_equal '', html
  end
end
