# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(email: "foobar@example.com", password: "foobar123", password_confirmation: "foobar123")
user2 = User.create!(email: "gordon.ramsey@example.com", password: "foobar123", password_confirmation: "foobar123")
user3 = User.create!(email: "julia.child@example.com", password: "foobar123", password_confirmation: "foobar123")

RECIPE_TAGS = {
  "Vegetarian" => "Recipes that exclude meat but may include dairy and eggs.",
  "Vegan" => "Plant-based recipes entirely free of animal products.",
  "Gluten-Free" => "Meals prepared without wheat, barley, rye, or gluten-containing ingredients.",
  "Quick & Easy" => "Simple recipes that require minimal prep and effort.",
  "30-Minute Meals" => "Dishes that can be prepared and served in half an hour or less.",
  "Healthy" => "Nutrient-dense meals focused on wholesome ingredients.",
  "Comfort Food" => "Hearty, soul-warming dishes that feel like home.",
  "Keto-Friendly" => "High-fat, low-carb recipes designed for a ketogenic lifestyle.",
  "One-Pot" => "Convenient meals cooked entirely in a single pot or pan.",
  "Meal Prep" => "Recipes ideal for cooking in bulk and storing for later.",
  "High-Protein" => "Meals with a significant amount of protein per serving.",
  "Low-Carb" => "Dishes that minimize carbohydrate intake.",
  "Budget-Friendly" => "Inexpensive recipes that maximize value without sacrificing flavor.",
  "Kid-Friendly" => "Approved by picky eaters; simple and approachable flavors.",
  "Seasonal" => "Highlighting ingredients at their peak freshness during specific times of year."
}

RANDOM_RECIPES = name_desc = {
    "Classic Beef Lasagna" => "A layered Italian dish involving pasta sheets, rich meat sauce (ragu), béchamel sauce, and mozzarella and ricotta cheeses. (Techniques: sauce making, layering, baking).",
    "Homemade Pad Thai" => "A popular Thai stir-fried rice noodle dish typically featuring shrimp or chicken, tofu, peanuts, bean sprouts, and a tangy tamarind sauce. (Techniques: stir-frying, sauce balancing).",
    "Chicken Tikka Masala" => "An iconic Indian-British dish where marinated, grilled chicken pieces are served in a rich, creamy, and spiced tomato sauce. (Techniques: marinating, grilling/broiling, simmering sauce).",
    "Sourdough Bread (Basic Loaf)" => "A foundational baking recipe requiring the use of a sourdough starter, long fermentation, and specific kneading and baking techniques. (Techniques: leavening, fermentation, high-heat baking).",
    "New York Cheesecake" => "A dense, smooth, and creamy dessert baked on a graham cracker crust, often using a water bath for even cooking. (Techniques: crust making, precision baking, chilling/setting).",
    "French Onion Soup (Soupe à l'Oignon Gratinée)" => "A deep, savory beef broth soup featuring slow-caramelized onions, topped with a large crouton and melted Gruyère cheese. (Techniques: slow caramelization, stock reduction, broiling/gratinéing).",
    "Spicy Black Bean Burgers" => "A vegetarian alternative that requires making a patty binder (often oats or breadcrumbs) and balancing the texture before pan-frying or baking. (Techniques: food processing/mixing, pan-frying/baking).",
    "Authentic Paella Valenciana" => "A Spanish rice dish cooked in a wide, shallow pan, incorporating chicken, rabbit, vegetables, saffron, and a key technique for achieving the crunchy bottom layer ('socarrat'). (Techniques: simmering, specialized heat management).",
    "Basic Vinaigrette Dressing" => "A foundational recipe showing the precise ratio and emulsification technique required to blend oil, vinegar, and seasonings. (Techniques: emulsification, whisking).",
    "Slow-Cooker Pulled Pork" => "A hands-off recipe detailing the rub application, cooking time, and shredding technique to achieve tender, barbecue-ready pork shoulder. (Techniques: slow cooking/braising, dry rub application)."
  }

def create_tags
  RECIPE_TAGS.each do |tag, desc|
    Tag.create!(tag_name: tag, description: desc)
  end
end

# Build the basic tags
create_tags

def get_random_tag
  Tag.friendly.find_by(tag_name: RECIPE_TAGS.keys.sample.downcase)
end


def create_recipe_with_ingredients_and_steps(name, desc, user)
  new_recipe = Recipe.create!(name: name, description: desc, sources: "https://randomblog.com/#{name}", user_id: user.id)
  new_recipe.tags = [ get_random_tag ]


  10.times do
    create_ingredient(new_recipe)
  end
  create_steps(new_recipe)
end

def create_ingredient(recipe)
  names = [ "flour", "sugar", "olive oil", "butter", "cheese" ]
  Ingredient.create!(name: names.sample, amount: [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ].sample, amount_unit: [ :liters, :ounces, :grams, :gallons, :cups, :teaspoons, :tablespoons ].sample, recipe_id: recipe.id)
end

def create_steps(recipe)
  steps = [
  "Preparation (Prep): Gather all ingredients, measure them, and perform any necessary pre-processing like chopping vegetables, preheating the oven, greasing pans, or bringing dairy products to room temperature.",
  "Mixing/Combining: Combine the prepared ingredients according to the recipe's instructions. This may involve sifting dry ingredients, whisking wet ingredients, creaming butter and sugar, or kneading dough.",
  "Cooking/Baking/Setting: Apply heat or cold to transform the ingredients. This is the core transformation step, involving stovetop cooking (sautéing, simmering), baking, deep-frying, grilling, or chilling (refrigerating/freezing) to set a mixture.",
  "Finishing/Garnishing: Perform final touches after the primary cooking process is complete. This includes adding a glaze, mixing in delicate fresh herbs, dusting with powdered sugar, adding a sauce, or plating the dish.",
  "Resting/Serving: Allow the dish to cool, rest, or set as necessary to improve texture (e.g., resting meat, cooling cakes). The final action is dividing the prepared food into portions and serving it."
]

  steps = steps.each_with_index do |step, idx|
    Step.create!(instruction: step, step_number: idx+1, duration: [ nil, 10, 30, 40 ].sample, duration_unit: [ :minutes, :hours, :days ].sample, recipe_id: recipe.id)
  end

  steps
end

users = [ user, user2, user3 ]
RANDOM_RECIPES.each do |name, desc|
  user = users.sample
  create_recipe_with_ingredients_and_steps(name, desc, user)
  pp "created new recipe for #{user.email}"
end
