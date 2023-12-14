node master.puppet {
    firewalld_port { 'Open port 8140 in the public zone':
        ensure   => present,
        zone     => 'public',
        port     => 8140,
        protocol => 'tcp',
    }

    include nginx

    nginx::resource::server { 'static':
        listen_port => 80,
        proxy       => 'http://192.168.50.10',
    }

    nginx::resource::server { 'dynamic':
        listen_port => 80,
        proxy       => 'http://192.168.50.15',
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

    file { '/var/www/html/index.html':
        ensure => file,
        source => "https://raw.githubusercontent.com/Fenikks/devops-files-23.08/master/05-puppet/files/index.html",
        replace => true,
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

    file { '/var/www/html/index.php':
        ensure => file,
        source => "https://raw.githubusercontent.com/Fenikks/devops-files-23.08/master/05-puppet/files/index.php",
        replace => true,
    }
}

node manicraft.puppet {
    include minecraft
}
