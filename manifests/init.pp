# Class to install and configure puppet-dynamodb-otp.
#
# Use this module to install and configure puppet-dynamodb-otp.
#
# @puppet-dynamodb-otp Declaring the class
#   include ::puppet-dynamodb-otp
#
# @param install_dir Location of puppet-dynamodb-otp binary release.
# @param install_method How to install puppet-dynamodb-otp.
# @param manage_dropin Manage the puppet-dynamodb-otp dropin.
# @param package_name Name of package to install.
# @param package_version Version of puppet-dynamodb-otp to install.
# @param archive_source Location of puppet-dynamodb-otp binary release.
# @param aws_region AWS region to expose to the puppetserver service.
class puppet_dynamodb_otp (
  Stdlib::Absolutepath $install_dir,
  Enum['archive','package'] $install_method ,
  Boolean $manage_dropin,
  String[1] $package_name,
  String[1] $package_version,
  Optional[Stdlib::HTTPUrl] $archive_source = undef,
  Optional[String[1]] $aws_region = undef
) {
  contain 'puppet_dynamodb_otp::install'
  if $puppet_dynamodb_otp::manage_dropin {
    class { 'puppet_dynamodb_otp::dropin':
      aws_region => $aws_region,
    }

    Class['puppet_dynamodb_otp::install']
    -> Class['puppet_dynamodb_otp::dropin']
  }
}
