class nano::install ($default = $::nano::params::default) inherits ::nano::params {
  package { 'nano':
    ensure => 'installed',
    name   => 'nano'
  }

  if str2bool($default) {
    file { '/etc/profile.d/nano.sh':
      ensure  => 'file',
      content => file('nano/nano.sh'),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Package['nano']
    }
  } else {
    file { '/etc/profile.d/nano.sh': ensure => 'absent' }
  }
}
