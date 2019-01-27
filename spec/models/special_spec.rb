RSpec.describe Special do
  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        special = Special.create(comedian_id: 1, runtime: 84)
        expect(special).to_not be_valid
      end

      it 'should be invalid if missing a comedian id' do
        special = Special.create(name: "Cinco", runtime: 84)
        expect(special).to_not be_valid
      end

      it "should be invalid if missing a runtime" do
        special = Special.create(name: "Cinco", comedian_id: 1)
        expect(special).to_not be_valid
      end
    end
  end

  describe 'class methods' do
    describe '.average_runtime' do
      it "can give an average of all specials" do
        Special.create(name: "Eighty", runtime: 80, comedian_id: 1)
        Special.create(name: "Sixty", runtime: 60, comedian_id: 1)

        actual = Special.average_runtime
        expected = 70

        expect(actual).to eq(expected)
      end
    end

    describe '.specials_for_comedians' do
      it "can return all specials for a selection of comedians" do
        Comedian.create(name: "Tim", age: 42, birthplace: "Somewhere")
        comedian = Comedian.first
        Special.create(name: "Eighty", runtime: 80, comedian_id: comedian.id)
        Special.create(name: "Sixty", runtime: 60, comedian_id: comedian.id)

        expected = Special.all
        actual = Special.specials_for_comedians(Comedian.all)

        expect(actual.first).to eq(expected.first)
        expect(actual.last).to eq(expected.last)
        expect(actual.count).to eq(expected.count)
      end
    end

    describe '.count_specials_by_comedian' do
      it "returns a grouping of the count of specials by comedian id" do
        Comedian.create(name: "Tim", age: 42, birthplace: "Somewhere")
        Comedian.create(name: "Jim", age: 50, birthplace: "Somewhere Else")
        tim = Comedian.first
        jim = Comedian.last
        Special.create(name: "Eighty", runtime: 80, comedian_id: tim.id)
        Special.create(name: "Sixty", runtime: 60, comedian_id: jim.id)

        expected = {tim.id => 1, jim.id => 1}
        actual = Special.count_specials_by_comedian

        expect(actual).to eq(expected)
      end
    end
  end
end
