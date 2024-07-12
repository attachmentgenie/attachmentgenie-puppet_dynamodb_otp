# Class to dropin puppet-dynamodb-otp.
#
# @api private
class puppet_dynamodb_otp::dropin {
  if $puppet_dynamodb_otp::manage_dropin {
    systemd::dropin_file { 'aws_env.conf':
      unit    => 'puppetserver.service',
      content => epp("${module_name}/aws_env.conf.epp", { 'rules' => [] }),
    }
  }
}
