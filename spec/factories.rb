Factory.define :category do |category|
  category.name "Vacuum Tubes"
end

Factory.define :sub_category do |sub_category|
  sub_category.name "Power Tube"
end

Factory.sequence :name do |n|
  "Tube #{n}"
end
