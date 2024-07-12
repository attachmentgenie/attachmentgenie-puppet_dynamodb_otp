# Class to install puppet-dynamodb-otp.
#
# @api private
class puppet_dynamodb_otp::install {
  case $puppet_dynamodb_otp::install_method {
    'package': {
      package { 'puppet-dynamodb-otp':
        ensure => $puppet_dynamodb_otp::package_version,
        name   => $puppet_dynamodb_otp::package_name,
      }
    }
    'archive': {
      file { 'puppet-dynamodb-otp install dir':
        ensure => directory,
        path   => $puppet_dynamodb_otp::install_dir,
      }

      archive { 'puppet-dynamodb-otp archive':
        cleanup      => true,
        creates      => "${puppet_dynamodb_otp::install_dir}/puppet-dynamodb-otp",
        extract      => true,
        extract_path => $puppet_dynamodb_otp::install_dir,
        path         => '/tmp/puppet-dynamodb-otp.tar.gz',
        source       => $puppet_dynamodb_otp::archive_source,
        require      => File['puppet-dynamodb-otp install dir'],
      }
    }
    default: {
      fail("Installation method ${puppet_dynamodb_otp::install_method} not supported")
    }
  }
}
