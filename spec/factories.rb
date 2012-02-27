Factory.define :category do |category|
  category.name "Vacuum Tubes"
end

Factory.sequence :name do |n|
    "Tube #{n}"
end

Factory.define :sub_category do |sub_category|
  sub_category.name "Power Tube"
end

Factory.define :product do |product|
  product.name "x12"
end

Factory.define :user do |user|
  user.email 'josh@gmail.com'
  user.password 'swordfish'
  user.password_confirmation 'swordfish'
end