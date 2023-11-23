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
    source => "https://raw.githubusercontent.com/Fenikks/master-puppet/production/files/wcg.service",
  }

  exec {'unpack wcg':
    command => "gunzip -c /tmp/wcg.gz > /opt/wordcloud/word-cloud-generator",
    require => File['/tmp/wcg.gz'],
    path => "/usr/bin",
  }

  file {'/opt/wordcloud/word-cloud-generator':
    owner => "wcg",
    group => "wcg",
    require => Exec['unpack wcg'],
  }


#- name: Change application file permissions
#  file:
#    dest: "{{ wcg_path }}/word-cloud-generator"
#    group: wcg
#    owner: wcg
#    mode: '0755'
#  notify: wcg-service


}
