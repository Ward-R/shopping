# ==== Homework =====

# Build a shopping application

# Create a 'market' that has items to sell OK
# User can buy one item OK

# User can checkout
# User can display their cart
# User can buy several items
# The market has limited supplies
# User can display their total bill

running = true
fruit_market = {
        'banana' => { price: 50, quantity: 10},
        'kiwi' => { price: 100, quantity: 25},
        'apple' => { price: 250, quantity: 2},
    }

cart = {}

# Total price calculated outside user_input because each case does not see
#   it and needs to calculate it in each case.
total_price = 0
def calculate_total(cart)
    total = 0
    cart.each do |item, details|
        total += details[:price] * details[:quantity]
    end
    return total
end

def user_input(choice, fruit_market, cart, total_price)
    case choice
    #shop - see items/add to cart
    when "shop"
        puts 'This is what we have in stock today:'
        fruit_market.each do |item, item_details|
            puts "#{item}: #{item_details[:price]} jpy, Quantity: #{item_details[:quantity]}"
        end

        puts ''
        puts 'What do you want to buy today?'
        print '> '
        item_to_buy = gets.chomp.downcase
            
        if fruit_market.key?(item_to_buy) && fruit_market[item_to_buy][:quantity] > 0
            # Add the item to the user cart
            if cart.key?(item_to_buy)
                cart[item_to_buy][:quantity] += 1
            else
                cart[item_to_buy] = {
                    price: fruit_market[item_to_buy][:price],
                    quantity: 1
                }
            end
            fruit_market[item_to_buy][:quantity] -= 1
        
            puts "#{item_to_buy} has been added to your cart!\n\n"
        else
            puts 'Sorry, we do not have that in stock...'
        end
    
    #display cart
    when "display"
        puts "This is your cart:"
        cart.each do |element, item_details|
            puts "Item: #{element} Unit Price: #{item_details[:price]} Quantity: #{item_details[:quantity]}"
        end
        total_price = calculate_total(cart)
        puts "Total price: #{total_price}"
    #checkout - see bill
    when "checkout"
        total_price = calculate_total(cart)
        puts "Total price: #{total_price}"
    else
        puts "Invalid choice"
    end
end

puts "-------------------------------"
puts 'Welcome to our Le Wagon market!'
puts "-------------------------------\n\n"

while running == true 
    # puts choices here:
    puts ""
    puts "--------------------------------------------"
    puts "shop - select and add items to cart"
    puts "display - display cart"
    puts "checkout - see total items/cost and checkout"
    puts "q - quit the program"
    puts "--------------------------------------------"
    print ">"

    choice = gets.chomp.downcase
    if choice == "q"
        running = false
        puts "Thanks for using Le Wagon market! See you again!"
    else
       total_price = user_input(choice, fruit_market, cart, total_price)
    end
end