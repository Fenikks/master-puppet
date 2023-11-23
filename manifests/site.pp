node default {
  package {'mysql':
    ensure => installed,
  }

  notify {"Running os ${facts['os']['name']} version ${facts['os']['release']['full']}":}
}

node slave1.puppet {
  package {'htop':
    ensure => present,
  }

  file {'/tmp/os-info.txt':
     ensure => file,
     content => "Running os ${facts['os']['name']} version ${facts['os']['release']['full']}",
  }
}
