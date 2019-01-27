RSpec.describe 'when I visit /comedians/new' do
  context 'as a user' do
    it "I am given a form to generate a new comedian" do
      visit '/comedians/new'

      expect(page).to have_field("comedian[name]")
      expect(page).to have_field("comedian[age]")
      expect(page).to have_field("comedian[birthplace]")
      expect(page).to have_button("Submit")
    end

    it "Submitting the form takes me back to the index" do
      visit '/comedians/new'

      page.fill_in("comedian[name]", with: "Tim")
      page.fill_in("comedian[age]", with: "42")
      page.fill_in("comedian[birthplace]", with: "Somewhere")
      click_on("Submit")

      expect(page.status_code).to eq(200)
      expect(current_path).to eq('/comedians')
    end

    it "After submitting the form I see the comedian I created" do
      visit '/comedians/new'

      page.fill_in("comedian[name]", with: "Tim")
      page.fill_in("comedian[age]", with: "42")
      page.fill_in("comedian[birthplace]", with: "Somewhere")
      click_on("Submit")

      within('.comedian-info') do
        expect(page).to have_content("Tim")
        expect(page).to have_content("42")
        expect(page).to have_content("Somewhere")
      end
    end
  end
end
