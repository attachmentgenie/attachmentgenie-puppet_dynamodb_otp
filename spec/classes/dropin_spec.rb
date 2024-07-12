# frozen_string_literal: true

require 'spec_helper'

describe 'puppet_dynamodb_otp' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with manage_dropin set to true' do
        let(:params) do
          {
            manage_dropin: true,
          }
        end

        it { is_expected.to contain_systemd__dropin_file('aws_env.conf') }
      end
    end
  end
end
