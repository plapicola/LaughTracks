RSpec.describe 'when I visit /comedians' do
  context 'as a visitor' do
    before :each do
      Comedian.create(name: "One", birthplace: "Somewhere", age: 42)
      Comedian.create(name: "Two", birthplace: "Somewhere Else", age: 45)
      Comedian.create(name: "Three", birthplace: "Somewhere", age: 3)
    end

    it 'I see a list of all comedians' do
      visit '/comedians'

      expected = "One"

      expect(page).to have_content(expected)
    end

    it "I see a name for each comedian" do
      visit '/comedians'

      id = Comedian.first.id

      within "#comedian-#{id}" do
        expect(page).to have_content("One")
        expect(page).to_not have_content("Two")
      end
    end

    it "I see a birthplace for each comedian" do
      visit '/comedians'

      id = Comedian.first.id

      within "#comedian-#{id}" do
        expect(page).to have_content("Somewhere")
        expect(page).to_not have_content("Somewhere Else")
      end
    end

    it "I see an age for each comedian" do
      visit '/comedians'

      id = Comedian.first.id

      within "#comedian-#{id}" do
        expect(page).to have_content("42")
        expect(page).to_not have_content("45")
      end
    end

    it "I see a image of the comedian" do
      visit '/comedians'

      id = Comedian.first.id

      expect(page).to have_xpath("//img[@src='https://m.media-amazon.com/images/G/01/imdb/images/nopicture/medium/name-2135195744._CB470041852_.png']")
    end

    it "I see a list of each comedian's specials' names" do
      Special.create(name: 'Uno', runtime: 35, comedian_id: Comedian.first.id)
      visit '/comedians'

      id = Comedian.first.id

      within "#comedian-#{id}" do
        expect(page).to have_content("Uno")
      end
    end

    it "I see a runtime in minutes for the comedian's specials" do
      runtime = 35
      Special.create(name: 'Uno', runtime: runtime, comedian_id: Comedian.first.id)
      visit '/comedians'

      id = Comedian.first.id

      within "#comedian-#{id}" do
        expect(page).to have_content("Runtime: #{runtime} minutes")
      end
    end

    describe "I see a collection of statistics at the top of the page" do
      it "including the averge age of comedians displayed" do
        expected = "Average Age: 30"

        within '#statistics' do
          expect(page).to have_content(expected)
        end
      end

      it "including the average run length of all specials on the page" do
        Special.create(name: 'Uno', runtime: 35, comedian_id: Comedian.first.id)
        Special.create(name: 'Dos', runtime: 45, comedian_id: Comedian.first.id)
        Special.create(name: 'Dos', runtime: 40, comedian_id: Comedian.last.id)

        expected = "Averge Runtime: 40 minutes"

        within '#statistics' do
          expect(page).to have_content(expected)
        end
      end

      it "including a unique list of all cities displayed on the page" do
        expected = "Somewhere, Somewhere Else"

        within '#statistics' do
          expect(page).to have_content(expected)
        end
      end
    end
  end
end
