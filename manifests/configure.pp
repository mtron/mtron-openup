class openup::configure inherits openup {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # Make sure that there are no conflicting parameters
  if $enable_cronjob == true and $admin_email == undef {
    fail("openup::admin_email must be set to enable update reports via cron")
  }

  if $autoinstall_updates == true and $enable_cronjob == false {
    fail("openup::enable_cronjob must be true for autoinstall_updates to work")
  }

  # Create openup config file
  file { '/etc/openup.conf':
    ensure   => present,
    content  => template('openup/openup-config.erb'),
    owner    => $openupuser,
    group    => $openupgroup,
    mode     => '0600',
  }

}
