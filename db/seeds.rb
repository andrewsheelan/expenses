# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning the database..."
Expense.destroy_all
Category.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
john = User.create!(
  email: 'john@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

jane = User.create!(
  email: 'jane@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Create categories
puts "Creating categories..."
john_categories = {
  'Groceries' => 'Food and household items',
  'Transportation' => 'Gas, public transit, and car maintenance',
  'Entertainment' => 'Movies, games, and fun activities',
  'Bills' => 'Monthly recurring expenses',
  'Shopping' => 'Clothing and personal items'
}.map do |name, description|
  john.categories.create!(name: name, description: description)
end

jane_categories = {
  'Food' => 'Groceries and dining out',
  'Travel' => 'Vacations and business trips',
  'Healthcare' => 'Medical expenses and insurance',
  'Education' => 'Books, courses, and training',
  'Utilities' => 'Electricity, water, and internet'
}.map do |name, description|
  jane.categories.create!(name: name, description: description)
end

# Helper method to generate random past date
def random_past_date
  rand(1..60).days.ago
end

# Create expenses for John
puts "Creating John's expenses..."
30.times do
  category = john_categories.sample
  Expense.create!(
    user: john,
    category: category,
    title: case category.name
    when 'Groceries' then ['Weekly groceries', 'Costco run', 'Fresh produce', 'Snacks'].sample
    when 'Transportation' then ['Gas', 'Bus fare', 'Car maintenance', 'Parking'].sample
    when 'Entertainment' then ['Movies', 'Video games', 'Concert tickets', 'Bowling'].sample
    when 'Bills' then ['Electricity', 'Water', 'Internet', 'Phone'].sample
    when 'Shopping' then ['Clothes', 'Shoes', 'Electronics', 'Home decor'].sample
    end,
    amount: rand(10.0..200.0).round(2),
    date: random_past_date
  )
end

# Create expenses for Jane
puts "Creating Jane's expenses..."
30.times do
  category = jane_categories.sample
  Expense.create!(
    user: jane,
    category: category,
    title: case category.name
    when 'Food' then ['Lunch out', 'Dinner with friends', 'Grocery shopping', 'Coffee'].sample
    when 'Travel' then ['Flight tickets', 'Hotel stay', 'Car rental', 'Travel insurance'].sample
    when 'Healthcare' then ['Doctor visit', 'Prescription', 'Health insurance', 'Dental care'].sample
    when 'Education' then ['Online course', 'Books', 'Workshop', 'Training materials'].sample
    when 'Utilities' then ['Power bill', 'Water bill', 'Internet service', 'Phone bill'].sample
    end,
    amount: rand(20.0..500.0).round(2),
    date: random_past_date
  )
end

# Create test conversations and messages
puts "Creating test conversations and messages..."
conversation = Conversation.create!(
  sender: john,
  recipient: jane
)

messages = [
  "Hey, how are you?",
  "I'm good, thanks! How about you?",
  "Great! Just checking out this new expense tracking app.",
  "It's pretty cool, right? I love the dark theme!",
  "Yeah, and the charts are really helpful."
]

messages.each_with_index do |content, index|
  Message.create!(
    conversation: conversation,
    user: index.even? ? john : jane,
    content: content,
    created_at: index.minutes.ago
  )
end

puts "Seed completed successfully!"
