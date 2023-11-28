class profile::web_server {
  package{'httpd':
    ensure => installed,
  }
}
