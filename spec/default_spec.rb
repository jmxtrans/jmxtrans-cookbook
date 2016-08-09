require 'chefspec'
require 'chefspec/berkshelf'
require_relative './support/matchers.rb'

RSpec.configure do |config|
    config.cookbook_path = '../'
end

describe 'jmxtrans::default' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'start jmxtrans service' do
        expect(chef_run).to start_service('jmxtrans')
    end
end
