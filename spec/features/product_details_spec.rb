require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
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

  scenario "They can click on product and go to product details page" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    within '.products-index' do 
      page.find("a.btn.btn-default.pull-right[href='/products/1']").click
      sleep 1
      save_screenshot
      # puts page.html
      # page.find("section.products-show")
      
      expect(page).to have_css 'section.products-show'
    end
  end

end