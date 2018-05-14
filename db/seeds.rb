# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test

def create_Category::Entity
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

def create_price_line
    PriceLine::Entity.new(0, 10000).save!
    PriceLine::Entity.new(10001, 50000).save!
    PriceLine::Entity.new(50001, 100000).save!
    PriceLine::Entity.new(100001, 500000).save!
    PriceLine::Entity.new(500001, 1000000).save!
end

def create_product
    240.times |i|
        # Product::Entity.new(name: Faker::Music.)
    end
end

def set_product_for_sale
end

def test
    Faker::Music.key
end