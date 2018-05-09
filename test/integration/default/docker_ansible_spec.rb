# spec/features/external_request_spec.rb
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