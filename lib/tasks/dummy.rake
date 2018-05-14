namespace :db do
    namespace :seed do
        namespace :dummy do

            task create: :environment do
                # create_categories
                # create_price_lines
                # create_products
                create_sales
            end

            def create_categories
                Category::Entity.transaction do
                    makeup = Category::Entity.new('MAKEUP')
                    makeup.save!

                    skin = Category::Entity.new('SKINCARE')
                    skin.save!

                    face = Category::Entity.new('Face')
                    face.save!

                    eyes = Category::Entity.new('Eyes')
                    eyes.save!

                    maskntreatment = Category::Entity.new('Masks & Treatment')
                    maskntreatment.save!

                    mois = Category::Entity.new('Moisturiser')
                    mois.save!

                    primer = Category::Entity.new('Face Primer')
                    primer.save!

                    foundation = Category::Entity.new('Faundation')
                    foundation.save!

                    eyeliner = Category::Entity.new('Eyeliner')
                    eyeliner.save!

                    shadow = Category::Entity.new('Eyeshadow')
                    shadow.save!

                    mask = Category::Entity.new('Mask')
                    mask.save!

                    peel = Category::Entity.new('Peel')
                    peel.save!

                    daymois = Category::Entity.new('Day Moisturiser')
                    daymois.save!

                    cream = Category::Entity.new('Night Cream')
                    cream.save!
            
                    face.belong_to(makeup)
                    eyes.belong_to(makeup)
            
                    maskntreatment.belong_to(skin)
                    mois.belong_to(skin)
            
                    primer.belong_to(face)
                    foundation.belong_to(face)
            
                    eyeliner.belong_to(eyes)
                    shadow.belong_to(eyes)
            
                    mask.belong_to(maskntreatment)
                    peel.belong_to(maskntreatment)
            
                    daymois.belong_to(mois)
                    cream.belong_to(mois)
                end
            end
        
            def create_price_lines
                PriceLine::Entity.transaction do
                    PriceLine::Entity.new(0, 10000).save!
                    PriceLine::Entity.new(10001, 50000).save!
                    PriceLine::Entity.new(50001, 100000).save!
                    PriceLine::Entity.new(100001, 500000).save!
                    PriceLine::Entity.new(500001, 1000000).save!
                end
            end
        
            def create_products
                categories = Category::Entity.all
                
                250.times do |i|
                    product = Product::Entity.new(name: "#{Faker::Pokemon.name}, #{Faker::Pokemon.location}")
                    product.transaction do
                        price = (Random.new.rand(100..700000) / 100).floor * 100
                        product.price = price
                        product.quantity = 3
                        product.save!

                        Category::Unit.categorize(categories[rand(categories.size)], product)
                        PriceLine::Unit.categorize_by_price(product)
                    end
                end
            end

            def create_sales
                Product::Entity.transaction do
                    Product::Entity.where(id: (0..250).step(10).map{ |i| i }).each do |product|
                        sale = Sale.new(
                            product: product,
                            description: '10th products 30% mega sale!',
                            percentage: 30
                        )

                        sale.save!
                    end
                end
            end

        end
    end
end