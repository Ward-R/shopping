# ==== Homework =====

# Build a shopping application

# Create a 'market' that has items to sell OK
# User can buy one item OK

# User can checkout
# User can display their cart
# User can buy several items
# The market has limited supplies
# User can display their total bill

fruit_market = {
    'banana' => 50,
    'kiwi' => 100,
    'apple' => 250
}

cart = []

puts 'Welcome to our Le Wagon market!'
puts 'This is what we have in stock today:'

fruit_market.each do |item, price|
    puts "#{item}: #{price} jpy"
end

puts ''
puts 'What do you want to buy today?'
print '> '
item_to_buy = gets.chomp.downcase

if fruit_market.key?(item_to_buy)
    # Add the item to the user cart
    cart << item_to_buy
    puts "#{item_to_buy} has been added to your cart!"
else
    puts 'Sorry, we do not have that in stock...'
end