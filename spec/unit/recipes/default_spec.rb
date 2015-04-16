#
# Cookbook Name:: mssql-demo
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mssql-demo::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("(Get-WindowsFeature -Name Web-Server).Installed").and_return(true)
    end

    it 'includes the webserver.rb recipe' do
      expect(chef_run).to include_recipe('mssql-demo::webserver')
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
