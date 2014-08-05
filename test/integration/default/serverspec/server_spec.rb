require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:/usr/bin:/bin'
  end
end

describe 'optoro_monit' do
  describe service('monit') do
    it { should be_enabled }
    it { should be_running }
  end
end
