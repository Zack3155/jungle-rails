require 'rails_helper'

RSpec.feature "Visitor see updates of cart icon", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Users can add item to the cart and the number in cart icon updates' do
    visit root_path
    page.all(".product button")[0].click
    within "nav" do
      expect(page).to have_content("Cart (1)")
    end
  end
end
