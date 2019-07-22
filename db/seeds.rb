# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer = User.last;
customer.is_chef = false;

chef = User.find(customer.id - 1);
chef.is_chef = true; 

chef_items = []
chef_items << Item.create(name: "Salmon", description: "Fantastic fish", price: "300", chef_id: chef.id)
chef_items << Item.create(name: "Caracol", description: "succulent snail", price: "400", chef_id: chef.id)
chef_items << Item.create(name: "Keylime Pie", description: "carbs carbs carbs", price: "250", chef_id: chef.id)

chef_menu = Menu.create(name: "Juan's Special", chef_id: chef.id)
chef_menu.is_current = true; 

chef_items.each { |item| chef_menu.items << item }

customer_order = Order.create(customer_id: customer.id, chef_id: chef.id)
customer_order << chef_items[0]
customer_order << chef_items[0]
customer_order << chef_items[1]
customer_order << chef_items[-1]
