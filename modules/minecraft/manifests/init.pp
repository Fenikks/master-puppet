class minecraft {
    file {'/opt/minecraft':
        ensure  => directory,
    }

    file {'/opt/minecraft/eula.txt':
        ensure => file,
        content => "eula=true",
    }

    package {'java-17-openjdk':
        ensure => installed,
    }

    file {'/opt/minecraft/server.jar':
        ensure => file,
        source => "https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar",
        replace => true,
    }

    file {'/etc/systemd/system/minecraft.service':
        ensure => file,
        source => "puppet:///modules/minecraft/minecraft.service",
    }

    service {'minecraft':
        ensure => running,
        enable => true,
    }
}