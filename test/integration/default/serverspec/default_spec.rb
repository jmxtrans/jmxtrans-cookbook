require 'serverspec'

set :backend, :exec

describe 'JMXTrans Installed' do
    it 'service JMXTrans is enabled' do
        expect(service('jmxtrans')).to be_enabled
    end

    it 'service JMXTrans is running' do
        expect(service('jmxtrans')).to be_running
    end
end
