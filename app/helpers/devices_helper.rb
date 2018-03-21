module DevicesHelper
  def devices_dropdown
    devices = Device.all.map{|d| [d.name, d.id ]}
  end
end
