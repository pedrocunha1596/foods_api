# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#FoodCategories
sugars = FoodCategory.create(name: "Sugar and Sugar products", description: "Sugar and Sugar products")
fruits = FoodCategory.create(name: "Fruits", description: "Fruits and derivates")

#ComponentCategories
macro = ComponentCategory.create(name: "Macroconstituintes", description: "Macrocomponents")
vitamins = ComponentCategory.create(name: "Vitaminas", description: "Vitamins")
minerals = ComponentCategory.create(name: "Minerais", description: "Minerals")

#Foods
yellow_sugar = Food.create(name: "Yellow sugar", edible_portion: 100, code: "IS502", energy_value: 300, food_category: sugars )
white_sugar = Food.create(name: "White sugar", edible_portion: 100, code: "IS503", energy_value: 400, food_category: sugars )
pjam = Food.create(name: "Pineapple jam", edible_portion: 100, code: "IS634", energy_value: 500, food_category: sugars)
pineapple = Food.create(name: "Pineapple", edible_portion: 68, code: "IS632", energy_value: 48, food_category: fruits)

#Components
carbohydrate = Component.create(name: "Carbohydrate", component_category: macro)
water = Component.create(name: "Water", component_category: macro)
protein = Component.create(name: "Protein", component_category: macro)
k = Component.create(name: "Potassium", component_category: minerals)
zinc = Component.create(name: "Zinco", component_category: minerals)
a_vitamin = Component.create(name: "Vitamin A", component_category: vitamins)
a_tocoferol = Component.create(name: "A-tocoferol", component_category: vitamins)


#Compositions
Composition.create(quantity: 97.5, food: yellow_sugar , component: carbohydrate)
Composition.create(quantity: 2, food: yellow_sugar , component: water)
Composition.create(quantity: 53, food: yellow_sugar , component: k)
Composition.create(quantity: 0.1, food: yellow_sugar , component: zinc)

Composition.create(quantity: 0.5, food: pjam , component: protein)
Composition.create(quantity: 2, food: pjam , component: a_vitamin)

Composition.create(quantity: 2, food: white_sugar , component: water)
Composition.create(quantity: 2, food: white_sugar, component: k)

Composition.create(quantity: 9.5, food: pineapple, component: carbohydrate)
Composition.create(quantity: 87.5, food: pineapple, component: water)
Composition.create(quantity: 0.5, food: pineapple, component: protein)
