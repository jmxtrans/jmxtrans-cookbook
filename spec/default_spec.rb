require 'chefspec'
require 'chefspec/berkshelf'
require_relative './support/matchers.rb'

RSpec.configure do |config|
  config.cookbook_path = '../'
end

describe 'jmxtrans-cookbook::default' do
  let(:chef_run){ChefSpec::SoloRunner.new.converge(described_recipe)}

  it 'installs jmxtrans zip' do
    expect(chef_run).to install_ark('jmxtrans')
  end

  it 'create file jmxtrans.sh' do
    expect(chef_run).to touch_file('/opt/jmxtrans/jmxtrans.sh')
  end

  it 'create init.d file jmxtrans' do
    expect(chef_run).to create_template('/etc/init.d/jmxtrans')
  end

  it 'create init.d default file jmxtrans' do
    expect(chef_run).to create_template('/etc/default/jmxtrans')
  end

  it 'create jmxtrans log directory' do
    expect(chef_run).to create_directory('/var/log/jmxtrans')
  end

  it 'create directory to store json file' do
    expect(chef_run).to create_directory('/opt/jmxtrans/json')
  end

  it 'create template set1.json' do
    expect(chef_run).to create_template('/opt/jmxtrans/json/set1.json')
  end

  it 'installs gzip' do
    expect(chef_run).to install_package('gzip')
  end
  
  it 'start jmxtrans service' do
    expect(chef_run).to start_service('jmxtrans')
  end
end
