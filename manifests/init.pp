class openup {

  class { 'openup::install': }
  -> class { 'openup::configure': }
}
