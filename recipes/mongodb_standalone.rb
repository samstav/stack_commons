# Encoding: utf-8
#
# Cookbook Name:: stack_commons
# Recipe:: mongodb_standalone
#
# Copyright 2014, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cookbook_file 'systemd service file' do
  path '/usr/lib/systemd/system/mongod.service'
  source 'mongod.service'
  owner 'root'
  group 'root'
  mode 0644
  action 'create'
  only_if { node['init_package'] == 'systemd' }
end

include_recipe 'chef-sugar'
include_recipe 'mongodb::mongodb_org_repo'
include_recipe 'mongodb::default'
include_recipe 'logstash_commons::mongodb' if node.deep_fetch('platformstack', 'elkstack_logging', 'enabled')
