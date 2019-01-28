RSpec.describe Comedian do
  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        comic = Comedian.create(age: 48, birthplace: "Town")
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing an age' do
        comic = Comedian.create(name: 'Mitch Hedberg', birthplace: "Town")
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing a birthplace' do
        comic = Comedian.create(name: 'Mitch Hedberg', age: 51)
        expect(comic).to_not be_valid
      end
    end
  end

  # describe 'Relations' do
  #   it 'should have many specials' do
  #     comic = Comedian.create(name: "Jim Gaffigan", age: 51, birthplace: "Somewhere")
  #
  #     actual = comic.specials
  #
  #     expect(actual).to_not raise_exception()
  #   end
  # end

  describe 'class methods' do
    before :each do
      Comedian.create(name: "Jim Gaffigan", age: 51, birthplace: "Somewhere")
      Comedian.create(name: "Tim Allen", age: 49, birthplace: "Somewhere Else")
      Comedian.create(name: "Some Guy", age: 50, birthplace: "Somewhere Else")
    end

    describe '.fetch_comedians' do
      it "can retrieve comedians based on a subselection" do
        expected = Comedian.first
        actual = Comedian.fetch_comedians(age: 51).first

        expect(actual).to eq(expected)
      end
    end

    describe '.average_age' do
      it 'returns an average age of all comedians' do
        expected = 50
        actual = Comedian.average_age

        expect(actual).to eq(expected)
      end

      it "returns an average age on a subset of comedians" do
        expected = 51
        actual = Comedian.average_age(age: 51)

        expect(actual).to eq(expected)
      end

      it "ignores limits that are not present in the table" do
        expected = 51
        actual = Comedian.average_age(age: 51, color: "pink")

        expect(actual).to eq(expected)
      end
    end

    describe '.birthplaces' do

      it 'returns a unique list of all birthplaces' do
        expected = ['Somewhere', 'Somewhere Else']
        actual = Comedian.birthplaces

        expect(actual).to eq(expected)
      end

      it "can return a list of birthplaces for a subset of comedias" do
        expected = ['Somewhere']
        actual = Comedian.birthplaces(age: 51)

        expect(actual).to eq(expected)
      end

      it "ignores limits that are not columns in the table" do
        expected = ['Somewhere']
        actual = Comedian.birthplaces(age: 51, color: "banana")

        expect(actual).to eq(expected)
      end

    end
  end
end
