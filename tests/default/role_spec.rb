# spec/features/external_request_spec.rb
require 'digest'

daemon_file = file('/etc/docker/daemon.json').content

md5sum = Digest::MD5.hexdigest(daemon_file)

describe apt('https://download.docker.com/linux/ubuntu') do
  it { should exist }
  it { should be_enabled }
end

describe package('docker-ce') do
  it {should be_installed}
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

describe docker_image('alpine:latest') do
  it {should exist}
  its('repo') {should eq 'alpine'}
  its('tag') {should eq 'latest'}
end

describe docker_container('myredis') do
  it {should exist}
  it {should be_running}
  its('id') {should_not eq ''}
  its('image') {should eq 'redis:latest'}
  its('repo') {should eq 'redis'}
  its('ports') {should_not eq []}
  its('command') {should eq 'docker-entrypoint.sh redis-server --appendonly yes'}
end
