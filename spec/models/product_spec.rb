

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should save" do
      cat1 = Category.find_or_create_by! name: 'Apparel'
      product = cat1.products.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 0,
        price: 64.99
        })
      expect(product).to be_valid
    end

    it "has a name" do
      cat1 = Category.find_or_create_by! name: 'Apparel'
      product = cat1.products.create({
        name:  nil,
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 0,
        price: 64.99
        })
      puts "THIS1:: #{product.errors.full_messages}"
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "has a price" do
      cat1 = Category.find_or_create_by! name: 'Apparel'
      product = cat1.products.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 0,
        price: nil
        })
      puts "THIS2:: #{product.errors.full_messages}"
      expect(product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it "has a quantity" do
      cat1 = Category.find_or_create_by! name: 'Apparel'
      product = cat1.products.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: nil,
        price: 64.99
        })
      puts "THIS3:: #{product.errors.full_messages}"
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "has a category" do
      #cat1 = Category.find_or_create_by! name: nil
      Product.create({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 0,
        price: 64.99
        })
      puts "THIS4:: #{product.errors.full_messages}"
      expect(product.errors.full_messages).to include("Category needs to exist.")
    end
  end
end