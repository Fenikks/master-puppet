node default{

include dev_user
include dev_editor

}

class dev_user (
  $usrnm = 'demouser',
  $pwd = '$1$pWicQEb0$lGXc.RyHF7VAG7tKOpIap1',
  $grps = ['wheel']
){
  user {$usrnm:
    ensure => present,
    managehome => true,
    groups => $grps,
    password => $pwd
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
