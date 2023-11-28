node default{

include dev_user
include dev_editor

}

class dev_user {
  user {'demouser':
    ensure => present,
    managehome => true,
    groups => ['wheel'],
    password => '$1$pWicQEb0$lGXc.RyHF7VAG7tKOpIap1'
  }
}

class dev_editor {
  package {'vim':
    ensure => present,
  }
  file {'/home/demouser/.vimrc':
    ensure => file,
    owner => "demouser",
    group => "demouser",
    content => "set number",
  }
}
