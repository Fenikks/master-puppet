node default{

include dev_user

}

class dev_user {
  user {'demouser':
    ensure => present,
    managehome => true,
    groups => ['wheel'],
    password => '$1$pWicQEb0$lGXc.RyHF7VAG7tKOpIap1'
  }
}
