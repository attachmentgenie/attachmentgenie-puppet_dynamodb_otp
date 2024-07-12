# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'with default parameters ', if: ['debian', 'redhat', 'ubuntu'].include?(os[:family]) do
  pp = <<-PUPPETCODE
  class { 'puppet_dynamodb_otp':
    archive_source => 'https://github.com/attachmentgenie/puppet-dynamodb-otp/releases/download/v0.1.0/puppet-dynamodb-otp_0.1.0_linux_x86_64.tar.gz',
    install_method => 'archive',
  }
PUPPETCODE

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe file('/opt/puppet-dynamodb-otp') do
    it { is_expected.to be_directory }
  end

  describe file('/opt/puppet-dynamodb-otp/puppet-dynamodb-otp') do
    it { is_expected.to be_file }
  end
end
