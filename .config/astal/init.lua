local App = require("astal.gtk3.app")
local Battery = require("lgi").require("AstalBattery")
local battery = Battery.get_default()
local Bluetooth = require("lgi").require("AstalBluetooth")
local bluetooth = Bluetooth.get_default()


App:start({
  main = function()
    -- you will instantiate Widgets here
    -- and setup anything else if you need
    print(battery.percentage)

    for _, d in ipairs(bluetooth.devices) do
      print(d.name)
    end
  end
})

