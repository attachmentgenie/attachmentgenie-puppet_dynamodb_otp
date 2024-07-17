# frozen_string_literal: true

require 'spec_helper'

describe 'puppet_dynamodb_otp::dropin' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        [
          'service { "puppetserver": ensure => running, }',
        ]
      end

      context 'with aws_region set to us-east-1' do
        let(:params) do
          {
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_systemd__dropin_file('aws_env.conf') }
      end
    end
  end
end
