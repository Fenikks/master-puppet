node default {
  package {'mysql':
    ensure => installed,
  }

  notify {"Running os ${facts['os']['name']} version ${facts['os']['release']['full']}":}

#- name: Unpack application file
#  shell: "gunzip -c /tmp/wcg.gz > {{ wcg_path }}/word-cloud-generator"
#  when: get_file.changed == true
#  notify: wcg-service

#- name: Change application file permissions
#  file:
#    dest: "{{ wcg_path }}/word-cloud-generator"
#    group: wcg
#    owner: wcg
#    mode: '0755'
#  notify: wcg-service

 
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
  
  }

  file {'/tmp/wcg.gz':
    ensure => file,
    source => "https://github.com/Fenikks/devops-files-23.08/raw/master/word-cloud-generator.gz",
  }

  file {'/etc/systemd/system/wcg.service':
    ensure => file,
    source => "https://raw.githubusercontent.com/Fenikks/master-puppet/production/files/wcg.service",
  }
}
