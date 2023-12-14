node master.puppet {
    firewalld_port { 'Open port 8080 in the public zone':
        ensure   => present,
        zone     => 'public',
        port     => 8140,
        protocol => 'tcp',
    }
}

node slave1.puppet {
    package{'httpd':
        ensure => installed,
    }

    service{ 'httpd':
        ensure => running,
        enable => true,
    }

    file { '/var/www/html/index.html'
        ensure => file,
        source => "https://raw.githubusercontent.com/Fenikks/devops-files-23.08/master/05-puppet/files/index.html"
        replace => true
    }
}

node slave2.puppet {
    package{['httpd','php']:
        ensure => installed,
    }

    service{ 'httpd':
      ensure => running,
      enable => true,
    }

    file { '/var/www/html/index.php'
        ensure => file,
        source => "https://raw.githubusercontent.com/Fenikks/devops-files-23.08/master/05-puppet/files/index.php"
        replace => true
    }
}

# node manicraft.puppet {
  
# }
