node default{

  class {'dev_user':
    pwd => '$1$zPtRgDqL$TRZ1y1F0N6bvWBHS3iKy11',
    grps => ['puppetdemo']
  }
  class {'dev_editor':
    usr => 'demouser',
  }  

}

class dev_user (
  $usrnm = 'demouser',
  $pwd = '$1$pWicQEb0$lGXc.RyHF7VAG7tKOpIap1',
  $grps = ['wheel']
){
  group {$grps:
    ensure => present,
  }
  user {$usrnm:
    ensure => present,
    managehome => true,
    groups => $grps,
    password => $pwd
  }
}

class dev_editor (
  $usr = 'nemo'
){
  package {'vim':
    ensure => present,
  }
  file {"/home/$usr/.vimrc":
    ensure => file,
    owner => $usr,
    group => $usr,
    content => "set number",
  }
}
