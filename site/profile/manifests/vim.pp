class profile::vim (
  $username = 'demouser'
){
  package {'vim':
    ensure => present,
  }
  file {"/home/$username/.vimrc":
    ensure => file,
    owner => $username,
    group => $username,
    content => "set number",
  }
}
