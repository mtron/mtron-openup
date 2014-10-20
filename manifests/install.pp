class openup::install {
  exec { 'install-openup':
    command => '/usr/bin/ftp -o /usr/local/sbin/openup https://stable.mtier.org/openup',
    creates => '/usr/local/sbin/openup',
  }

  exec { 'install-updates':
    refreshonly => true,
    command     => '/usr/local/sbin/openup | mail root',
    timeout     => 0,
  }

  file { '/usr/local/sbin/openup':
    mode    => '0755',
    ensure  => present,
    require => Exec['install-openup'],
	notify  => Exec['install-updates'],
  }
}
