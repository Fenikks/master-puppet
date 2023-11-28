class profile::dev_user (
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
