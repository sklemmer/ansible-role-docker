# spec/features/external_request_spec.rb
require 'digest'

daemon_file = file('/etc/docker/daemon.json').content

md5sum = Digest::MD5.hexdigest(daemon_file)

describe apt('https://download.docker.com/linux/ubuntu') do
  it {should exist}
  it {should be_enabled}
end

describe package('docker-ce') do
  it {should be_installed}
  its('version') {should match /17.12.*/}
end

describe service('docker') do
  it {should be_installed}
  it {should be_enabled}
  it {should be_running}
end

describe file('/etc/docker/daemon.json') do
  it {should exist}
  it {should be_file}
  it {should_not be_directory}
  its('md5sum') {should eq md5sum}
end