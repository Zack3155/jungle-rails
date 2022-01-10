require "rails_helper"

RSpec.describe Product, type: :model do
  test_category = Category.new(name: "Product test category")
  subject do
      described_class.new(
    name: "Object created for testing",
    price_cents: 310,
    quantity: 11,
    category: test_category
    )
  end
    
  describe 'Validations' do
    # validation tests/examples here
    it 'Should create an object with valid fileds for testing' do
      expect(subject).to be_valid
    end

    it 'invalid with missing name' do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end

    it 'invalid with missing price' do
      subject.price_cents = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    it 'invalid with missing quantity' do
      subject.quantity = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'invalid with missing category' do
      subject.category = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end

  end
end