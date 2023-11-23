node default {
  package {'mysql':
    ensure => installed,
  }
}

node slave1.puppet {
  package {'htop':
    ensure => present,
  }
}
