class openup::params {

  if $::osfamily == 'OpenBSD' {
    $openupuser = 'root'
    $openupgroup = 'daemon'
  } else {
    fail("Class['openup']: Unsupported osfamily: ${::osfamily}")
  }

}
