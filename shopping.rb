# ==== Homework =====

# Build a shopping application

# Create a 'market' that has items to sell OK
# User can buy one item OK

# User can checkout
# User can display their cart
# User can buy several items
# The market has limited supplies
# User can display their total bill

# token to keep program running until user quits
running = true

# Store inventory hash
fruit_market = {
        'banana' => { price: 50, quantity: 10},
        'kiwi' => { price: 100, quantity: 25},
        'apple' => { price: 250, quantity: 50},
        'kaki' => { price: 400, quantity: 15},
        'pineapple' => { price: 500, quantity: 5},
        'mikan' => { price: 50, quantity: 100},
        'suika' => { price: 1100, quantity: 5}
    }

# Hash for user shopping cart
cart = {}

# Total price calculated outside user_input because each case does not see
# it and needs to calculate it in each case.
total_price = 0
def calculate_total(cart)
    total = 0
    cart.each do |item, details|
        total += details[:price] * details[:quantity]
    end
    return total
end

# Method to handle user input and transactions
def user_input(choice, fruit_market, cart, total_price)
    case choice
    #shop - see items/add to cart
    when "shop"
        puts "------------------------------------"
        puts "This is what we have in stock today:"
        puts "------------------------------------"
        fruit_market.each do |item, item_details|
            puts "#{item}: #{item_details[:price]}￥, Quantity: #{item_details[:quantity]}"
        end

        puts ""
        puts "What do you want to buy today?"
        print "> "
        item_to_buy = gets.chomp.downcase
        puts ""
        puts "How many #{item_to_buy}"
        print "> "
        purchase_quantity = gets.chomp.to_i    

        # Check if item_to_buy exists in inventory and if there is enough in stock
        if fruit_market.key?(item_to_buy) && purchase_quantity <= fruit_market[item_to_buy][:quantity]
            # Add the item to the user cart
            if cart.key?(item_to_buy)  # Checks if item is in cart already and increases
                cart[item_to_buy][:quantity] += purchase_quantity
            else    # Adds new item(s) to cart
                cart[item_to_buy] = {
                    price: fruit_market[item_to_buy][:price],
                    quantity: purchase_quantity
                }
            end
            # Adjusts fruit_market remaining inventory
            fruit_market[item_to_buy][:quantity] -= purchase_quantity
        
            puts "#{item_to_buy} has been added to your cart!\n\n"
        else
            puts "Sorry, we do not have that in stock..."
        end
    
    #display cart
    when "display"
        puts "This is your cart:"
        cart.each do |element, item_details|
            puts "Item: #{element} Unit Price: #{item_details[:price]}￥ Quantity: #{item_details[:quantity]}"
        end
        total_price = calculate_total(cart)
        puts "Total price: #{total_price}￥"
    #checkout - See totals, assign payment method, clear cart
    when "checkout"
        if cart.empty?  # Checks if user has added items to cart yet
            puts "Cart is empty, please add items before checkout"
        else    # If items are in cart, checkout can proceed
            puts "This is your cart:"
            cart.each do |element, item_details|
                puts "Item: #{element} Unit Price: #{item_details[:price]}￥ Quantity: #{item_details[:quantity]}"
            end
            total_price = calculate_total(cart)
            puts "Total price: #{total_price}￥"
            puts "-----------------------------"
            puts "How would you like to pay?"
            puts "cod - Cash on deliver"
            puts "konbini - Pay at konbini"
            puts "bank - bank transfer"
            print "> "
            payment_type = gets.chomp.downcase
            puts "-----------------------------"
            if payment_type == "cod"
                puts "Purchase to be delivered to address on file"
                puts "Please pay on delivery to post"
                puts "We look forward to serving you again!"
                cart.clear
            elsif payment_type == "konbini"
                puts "Please pay at konbini. Details will be emailed to address on file"
                puts "We look forward to serving you again!"
                cart.clear
            elsif payment_type == "bank"
                puts "Please pay with bank transfer. Details will be emailed to address on file"
                puts "We look forward to serving you again!"
                cart.clear
            else
                puts "Invalid choice"
            end
        end
    else
        puts "Invalid choice"
    end
end


# Main
print "\e[2J"  # Clear the entire screen
print "\e[H"   # Move the cursor to the top-left corner
puts "--------------------------------------------"
puts "      Welcome to our Le Wagon market!"
puts "--------------------------------------------\n"

while running == true 
    # puts choices here:
    puts ""
    puts "-------------------MENU---------------------"
    puts "shop     - select and add items to cart"
    puts "display  - display cart"
    puts "checkout - see total items/cost and checkout"
    puts "q        - quit the program"
    puts "--------------------------------------------"
    print ">"

    # Get user menu choice
    choice = gets.chomp.downcase
    if choice == "q"
        # Terminate program loop if user quits
        running = false
        puts "Thanks for using Le Wagon market! See you again!"
    else
        # Run user_input method and return total_price to global var
        total_price = user_input(choice, fruit_market, cart, total_price)
    end
end