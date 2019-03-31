json.array! @middle_categories do |middle_category|
  json.id middle_category.id
  json.parent_id middle_category.parent_id
  json.name middle_category.name
end
