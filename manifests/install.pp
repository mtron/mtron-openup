class openup::install inherits openup {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  exec { 'install-openup':
    command => "/usr/bin/ftp -o /usr/local/sbin/openup $openup_url",
    creates => '/usr/local/sbin/openup',
  }

  if ( $enable_cronjob == true ) {
    if ( $autoinstall_updates == true ) {
      cron { 'openup-install-updates':
        ensure      => present,
        command     => '/usr/local/sbin/openup',
        environment => ["MAILFROM=$sender_email","MAILTO=$admin_email"],
        user        => $openupuser,
        hour        => '2',
        minute      => '0',
      }
      cron { 'openup-check-updates':
        ensure      => absent,
      }
    } else {
      cron { 'openup-check-updates':
        ensure      => present,
        command     => '/usr/local/sbin/openup -c',
        environment => ["MAILFROM=$sender_email","MAILTO=$admin_email"],
        user        => $openupuser,
        hour        => '2',
        minute      => '0',
      }
      cron { 'openup-install-updates':
        ensure      => absent,
      }
    }
  } else {
    cron { 'openup-check-updates':
      ensure      => absent,
    }
    cron { 'openup-install-updates':
      ensure      => absent,
    }
  }

  file { '/usr/local/sbin/openup':
    ensure  => present,
    mode    => $mode,
    require => Exec['install-openup'],
  }
}
