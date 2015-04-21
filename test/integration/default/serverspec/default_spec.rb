require 'serverspec'

set :backend, :exec

describe "JMXTrans Installed" do
  it "JMXTrans copied" do
    expect(file '/opt/jmxtrans').to be_directory
  end

  it "JMXTrans shell script available" do
    expect(file '/opt/jmxtrans/jmxtrans.sh').to be_file
  end

  it "JMXTrans shell script mode is correct" do
    expect(file '/opt/jmxtrans/jmxtrans.sh').to be_mode 755
  end

  it "JMXTrans default file is available" do
    expect(file '/etc/default/jmxtrans').to be_file
  end

  it "JMXTrans default file mode is correct" do
    expect(file '/etc/default/jmxtrans').to be_mode 644
  end

  it "JMXTrans log directory is available" do
    expect(file '/var/log/jmxtrans').to be_directory
  end

  it "JMXTrans log directory mode is correct" do
    expect(file '/var/log/jmxtrans').to be_mode 755
  end

  it "JMXTrans json directory mode is available" do
    expect(file '/opt/jmxtrans/json').to be_directory
  end

  it "JMXTrans set1.json file is available" do
    expect(file '/opt/jmxtrans/json/set1.json').to be_file
  end

  it "Package gzip is installed" do
    expect(package 'gzip').to be_installed
  end

  it "service JMXTrans is enabled" do
    expect(service 'jmxtrans').to be_enabled
  end

  it "service JMXTrans is running" do
    expect(service 'jmxtrans').to be_running
  end

end
