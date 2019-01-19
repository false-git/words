require "application_system_test_case"

class WordsetsTest < ApplicationSystemTestCase
  setup do
    @wordset = wordsets(:one)
  end

  test "visiting the index" do
    visit wordsets_url
    assert_selector "h1", text: "Wordsets"
  end

  test "creating a Wordset" do
    visit wordsets_url
    click_on "New Wordset"

    fill_in "Description", with: @wordset.description
    fill_in "Name", with: @wordset.name
    click_on "Create Wordset"

    assert_text "Wordset was successfully created"
    click_on "Back"
  end

  test "updating a Wordset" do
    visit wordsets_url
    click_on "Edit", match: :first

    fill_in "Description", with: @wordset.description
    fill_in "Name", with: @wordset.name
    click_on "Update Wordset"

    assert_text "Wordset was successfully updated"
    click_on "Back"
  end

  test "destroying a Wordset" do
    visit wordsets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wordset was successfully destroyed"
  end
end
