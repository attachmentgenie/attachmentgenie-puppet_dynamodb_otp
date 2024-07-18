# frozen_string_literal: true

require 'spec_helper'

describe 'puppet_dynamodb_otp' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with archive_source set to special.tar.gz' do
        let(:params) do
          {
            archive_source: 'special.tar.gz',
            install_method: 'archive',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to raise_error(%r{expects a match for Stdlib::HTTPUrl}) }
      end

      context 'with archive_source set to http://localhost/special.tar.gz' do
        let(:params) do
          {
            archive_source: 'http://localhost/special.tar.gz',
            install_method: 'archive',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_archive('puppet-dynamodb-otp archive').with_source('http://localhost/special.tar.gz') }
      end

      context 'with install_dir set to /opt/special' do
        let(:params) do
          {
            install_dir: '/opt/special',
            install_method: 'archive',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_file('puppet-dynamodb-otp install dir').with_path('/opt/special') }
        it { is_expected.to contain_archive('puppet-dynamodb-otp archive').with_creates('/opt/special/puppet-dynamodb-otp') }
        it { is_expected.to contain_archive('puppet-dynamodb-otp archive').with_extract_path('/opt/special') }
        it { is_expected.to contain_archive('puppet-dynamodb-otp archive').that_requires('File[/opt/special]') }
      end

      context 'with install_method set to archive' do
        let(:params) do
          {
            install_dir: '/opt/puppet-dynamodb-otp',
            install_method: 'archive',
            package_name: 'puppet-dynamodb-otp',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_file('puppet-dynamodb-otp install dir').that_comes_before('Archive[puppet-dynamodb-otp archive]') }
        it { is_expected.to contain_archive('puppet-dynamodb-otp archive') }
        it { is_expected.not_to contain_package('puppet-dynamodb-otp') }
      end

      context 'with install_method set to package' do
        let(:params) do
          {
            install_dir: '/opt/puppet-dynamodb-otp',
            install_method: 'package',
            package_name: 'puppet-dynamodb-otp',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.not_to contain_file('puppet-dynamodb-otp install dir').that_comes_before('Archive[puppet-dynamodb-otp archive]') }
        it { is_expected.not_to contain_archive('puppet-dynamodb-otp archive') }
        it { is_expected.to contain_package('puppet-dynamodb-otp') }
      end

      context 'with package_name set to specialpackage' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'specialpackage',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_package('puppet-dynamodb-otp').with_name('specialpackage') }
      end

      context 'with package_version set to 42.42.42' do
        let(:params) do
          {
            install_method: 'package',
            package_name: 'puppet-dynamodb-otp',
            package_version: '42.42.42',
            aws_region: 'us-east-1',
          }
        end

        it { is_expected.to contain_package('puppet-dynamodb-otp').with_ensure('42.42.42') }
      end
    end
  end
end
