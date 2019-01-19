require 'test_helper'

class WordsetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wordset = wordsets(:one)
  end

  test "should get index" do
    get wordsets_url
    assert_response :success
  end

  test "should get new" do
    get new_wordset_url
    assert_response :success
  end

  test "should create wordset" do
    assert_difference('Wordset.count') do
      post wordsets_url, params: { wordset: { description: @wordset.description, name: @wordset.name } }
    end

    assert_redirected_to wordset_url(Wordset.last)
  end

  test "should show wordset" do
    get wordset_url(@wordset)
    assert_response :success
  end

  test "should get edit" do
    get edit_wordset_url(@wordset)
    assert_response :success
  end

  test "should update wordset" do
    patch wordset_url(@wordset), params: { wordset: { description: @wordset.description, name: @wordset.name } }
    assert_redirected_to wordset_url(@wordset)
  end

  test "should destroy wordset" do
    assert_difference('Wordset.count', -1) do
      delete wordset_url(@wordset)
    end

    assert_redirected_to wordsets_url
  end
end
