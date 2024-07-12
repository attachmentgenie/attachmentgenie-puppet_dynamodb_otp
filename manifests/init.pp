# Class to install and configure puppet-dynamodb-otp.
#
# Use this module to install and configure puppet-dynamodb-otp.
#
# @puppet-dynamodb-otp Declaring the class
#   include ::puppet-dynamodb-otp
#
# @param archive_source Location of puppet-dynamodb-otp binary release.
# @param install_dir Location of puppet-dynamodb-otp binary release.
# @param install_method How to install puppet-dynamodb-otp.
# @param manage_dropin Manage the puppet-dynamodb-otp dropin.
# @param package_name Name of package to install.
# @param package_version Version of puppet-dynamodb-otp to install.
class puppet_dynamodb_otp (
  Stdlib::Absolutepath $install_dir,
  Enum['archive','package'] $install_method ,
  Boolean $manage_dropin,
  String[1] $package_name,
  String[1] $package_version,
  Optional[Stdlib::HTTPUrl] $archive_source = undef,
) {
  contain 'puppet_dynamodb_otp::install'
  contain 'puppet_dynamodb_otp::dropin'

  Class['puppet_dynamodb_otp::install']
  -> Class['puppet_dynamodb_otp::dropin']
}
