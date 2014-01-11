require 'spec_helper'

feature "User adds a book", %Q{
  As an authenticated user
  I want to add a book
  So that I can track it on my list
} do

  # Acceptance Criteria:
  # * I must specify the book's title and author
  # * If I do not specify title and author, I am presented with an error
  # * I can optionally specify date completed
  # * If I specify title and author, the book is saved

  scenario "happy path" do
    count = Book.all.count
    user = FactoryGirl.create(:user)
    login(user)
    visit '/'
    click_on "Add Book"
    fill_in "Title", with: "The Great Gatsby"
    fill_in "Author", with: "F Scott Fitzgerald"
    click_on "Add Book"

    expect(page).to have_content("The Great Gatsby")
    expect(Book.all.count).to eq(count + 1)
    expect(Book.last.user_id).to eq(user.id)
  end

  scenario "missing input" do
    count = Book.all.count
    user = FactoryGirl.create(:user)
    login(user)
    visit '/'
    2.times do click_on "Add Book"
    end

    expect(page).to have_content("Error")
    expect(Book.all.count).to eq(count)
  end

  # end

  # context "not logged in" do
  #   it "won't authorize you" do
  #     expect { visit new_game_path }.to raise_error(ActionController::RoutingError, "Not Found")
  #   end

  # end

end
