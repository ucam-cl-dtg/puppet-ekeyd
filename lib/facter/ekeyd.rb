Facter.add('ekeyd_key_present') do
  setcode do
    FileTest.exists?('/proc/bus/usb/devices') && \
      !(File.read('/proc/bus/usb/devices') =~ /Product=Entropy Key/).nil?
  end
end
Facter.add('ekeyd_key_present') do
  confine :operatingsystem => %w{Debian Ubuntu}
  setcode do
    case FileTest.exists? '/usr/bin/lsusb'
    when False
      False
    else
      !`lsusb | grep "Entropy Key"`.empty?
    end
  end
end
