class openup::configure {
  cron { 'openup':
    command => '/usr/local/sbin/openup',
    user    => root,
    hour    => 2,
    minute  => 0,
  }
}
