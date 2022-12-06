# frozen_string_literal: true

require 'test_helper'

class CartSessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get cart_sessions_index_url
    assert_response :success
  end

  test 'should get show' do
    get cart_sessions_show_url
    assert_response :success
  end

  test 'should get new' do
    get cart_sessions_new_url
    assert_response :success
  end

  test 'should get edit' do
    get cart_sessions_edit_url
    assert_response :success
  end

  test 'should get create' do
    get cart_sessions_create_url
    assert_response :success
  end

  test 'should get update' do
    get cart_sessions_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get cart_sessions_destroy_url
    assert_response :success
  end

  test 'should get update_quantity' do
    get cart_sessions_update_quantity_url
    assert_response :success
  end
end
