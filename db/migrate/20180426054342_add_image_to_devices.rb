class AddImageToDevices < ActiveRecord::Migration[5.1]
  def self.up
    change_table :devices do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :devices, :image
  end
end
