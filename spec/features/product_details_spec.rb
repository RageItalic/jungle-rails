require 'rails_helper'

RSpec.feature "VISITOR NAVIGATES TO Product Details", type: :feature, js: true do

  # before :each do
  #   @category = Category.create! name: 'Apparel'
  #   # @product = @category.products.create!(
  #   #     name:  Faker::Hipster.sentence(3),
  #   #     description: Faker::Hipster.paragraph(4),
  #   #     image: open_asset('apparel1.jpg'),
  #   #     quantity: 10,
  #   #     price: 64.99
  #   #   )

  #   10.times do |n|
  #     @category.products.create!(
  #       name:  Faker::Hipster.sentence(3),
  #       description: Faker::Hipster.paragraph(4),
  #       image: open_asset('apparel1.jpg'),
  #       quantity: 10,
  #       price: 64.99
  #     )
  #   end
  # end

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
    @product = @category.products.first
  end

  scenario "They click on a product" do
    # ACT
    visit root_path
    # puts page.html

    # click on a the @product

    click_link("product-" + @product.id.to_s)
    sleep 2
    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_content @product.name
    # expect(page).to have_css 'article.product', count: 10
  end




end

