class wcg {
  group {'wcg':
    ensure => present,
  }

  user {'wcg':
    ensure => present,
    groups => ['wcg'],
    require => Group['wcg'],
  }

  file {'/opt/wordcloud':
    ensure  => directory,
    owner => "wcg",
    group => "wcg",
    before => Exec['unpack wcg'],
  }

  file {'/tmp/wcg.gz':
    ensure => file,
    source => "https://github.com/Fenikks/devops-files-23.08/raw/master/word-cloud-generator.gz",
    
  }

  file {'/etc/systemd/system/wcg.service':
    ensure => file,
    source => "puppet:///modules/wcg/wcg.service",
  }

  exec {'unpack wcg':
    command => "gunzip -c /tmp/wcg.gz > /opt/wordcloud/word-cloud-generator",
    require => File['/tmp/wcg.gz'],
    path => "/usr/bin",
    notify => Service['wcg'],
  }

  file {'/opt/wordcloud/word-cloud-generator':
    owner => "wcg",
    group => "wcg",
    mode => "755",
    require => Exec['unpack wcg'],
  }

  service {'wcg':
    ensure => running,
    enable => true,
  }
  
  service {'firewalld':
    ensure => stopped,
    enable => false,
  }
}
