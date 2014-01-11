require 'spec_helper'

feature "User views their booklist", %Q{
  As an authenticated user
  I want to see the books I've completed
  So that I can know if I have reached 50
} do

  # Acceptance Criteria:
  # * If I have added no books, no books should be displayed
  # * Books that I have added should be displayed
  # * Books added by other users should not be displayed

  scenario "with no books" do
    user = FactoryGirl.create(:user)
    login(user)
    visit user_path(user)

    expect(page).to have_button("Add Book")
  end

  scenario "with book only created by user" do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.create(:book, user: user)
    login(user)
    visit user_path(user)

    expect(page).to have_content(book.title)
  end

  scenario "with books created by multiple users" do
    user = FactoryGirl.create(:user)
    book1 = FactoryGirl.create(:book, user: user)
    book2 = FactoryGirl.create(:book)
    login(user)
    visit user_path(user)

    expect(page).to have_content(book1.title)
    expect(page).to_not have_content(book2.title)
  end

end
