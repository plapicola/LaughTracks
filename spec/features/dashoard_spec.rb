RSpec.describe 'when I visit /' do
  context 'as a visitor' do
    it "I have the ability to navigate to the comedians page" do
      visit '/'

      expect(page).to have_link("All Comedians", href: '/comedians')
    end

    it "I have the ability to navigate to the new page" do
      visit '/'

      expect(page).to have_link("New Comedian", href: '/comedians/new')
    end

    it "I see a welcome image" do
      visit '/'

      expect(page).to have_xpath("//img[@src='http://www.irishcraftbeerfestival.ie/s/micro.jpg']")
    end
  end
end
