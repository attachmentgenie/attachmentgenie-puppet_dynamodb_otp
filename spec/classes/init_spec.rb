# frozen_string_literal: true

require 'spec_helper'

describe 'puppet_dynamodb_otp' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:params) { { aws_region: 'us-east-1' } }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('puppet_dynamodb_otp') }
        it { is_expected.to contain_class('puppet_dynamodb_otp::install').that_comes_before('Class[Puppet_dynamodb_otp::Dropin]') }
        it { is_expected.to contain_class('puppet_dynamodb_otp::dropin') }
        it { is_expected.to contain_systemd__dropin_file('aws_env.conf') }
        it { is_expected.to contain_package('puppet-dynamodb-otp') }
      end
    end
  end
end
