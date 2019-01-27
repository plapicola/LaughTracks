RSpec.describe 'when I visit /comedians/new' do
  context 'as a user' do
    it "I am given a form to generate a new comedian" do
      visit '/comedians/new'

      expect(page).to have_field("comedian[name]")
      expect(page).to have_field("comedian[age]")
      expect(page).to have_field("comedian[birthplace]")
      expect(page).to have_button("Submit")
    end
  end
end
