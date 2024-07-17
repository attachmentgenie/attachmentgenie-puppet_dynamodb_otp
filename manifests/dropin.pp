# Class to dropin puppet-dynamodb-otp.
#
# @api private
# @param aws_region AWS region to expose to the puppetserver service.
# @param puppetserver Name of the puppetserver service.
class puppet_dynamodb_otp::dropin (
  String $aws_region,
  String $puppetserver = 'puppetserver',
) {
  systemd::dropin_file { 'aws_env.conf':
    unit    => 'puppetserver.service',
    content => epp("${module_name}/aws_env.conf.epp", { 'aws_region' => $aws_region }),
    notify  => Service[$puppetserver],
  }
}
