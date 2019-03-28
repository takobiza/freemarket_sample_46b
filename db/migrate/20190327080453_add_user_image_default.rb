class AddUserImageDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :image, "member_photo_noimage_thumb.png")
  end
end
