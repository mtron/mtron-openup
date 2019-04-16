# == openup
#
# This puppet module installs and configures openup,
# the OpenBSD package update service by m:tier
# https://mtier.org/solutions/apps/openup/
#
# openup can be run standalone or via cron to check for - and install -
# security updates in packages and the base system by using the regular
# OpenBSD pkg tools.
#
# M:Tier provides these updates free of charge for the current OpenBSD stable 
# release. They also offer backports for the two most recent OpenBSD releases to
# subscribers. See: https://stable.mtier.org/subscriptions for more information.
#
# Notice: I am not affiliated to M:Tier in any way. If you experience Problems
# with an update please contact M:Tier via stable@support.mtier.org
#
# === Parameters
#
# [*openup_url*] (default: 'https://stable.mtier.org/openup')
#   URL to the latest openup version
#
# [*openbsd_mirror*] (default: 'https://cdn.openbsd.org/pub/OpenBSD')
#   OpenBSD mirror to use
#
# [*openbsd_mtier_url*] (default: 'https://stable.mtier.org/updates')
#   URL for the M:Tier packages update service
#
# [*openbsd_vul_db *] (default: 'https://stable.mtier.org/vuxml')
#   URL for the current OpenBSD release of the latest vulnerabilities database
#
# [*owner*] (default: root)
#   The system user that will run the update check
#
# [*group*] (default: daemon)
#   The system group that will run the update check
#
# [*mode*] (default: 0755)
#   Default file mode for the openup binary
#
# [*admin_email*] (default: undef)
#   The email address of the admin user. This user will receive the
#   email with available updates or installed updates
#
# [*sender_email*] (default: openup@$::fqdn)
#   The sender email address
#
# [*enable_cronjob*] (default: false)
#   Automatic update check via cron
#   Requires: admin_email => 'webmaster@mydomain.com'
#
# [*autoinstall_updates*] (default: false)
#   Automatic installation of available updates
#   Requires: enable_cronjob => true
#
# === Examples
#
# check for Package updates via cronjob:
#
#  class { 'openup':
#    admin_email    => 'webmaster@mydomain.com',
#    enable_cronjob => true,
#  }
#
# auto-install updates:
#
#  class { 'openup':
#    admin_email         => 'webmaster@mydomain.com',
#    enable_cronjob      => true,
#    autoinstall_updates => true,
#  }
#
# overly complicated:
#
#  class { 'openup':
#    openup_url          => 'https://stable.mtier.org/openup',
#    openbsd_mirror      => 'https://cdn.openbsd.org/pub/OpenBSD',
#    openbsd_mtier_url   => 'https://stable.mtier.org/updates',
#    openbsd_vul_db      => 'https://stable.mtier.org/vuxml',
#    admin_email         => 'webmaster@mydomain.com',
#    sender_email        => 'monitoring@mydomain.com',
#    enable_cronjob      => true,
#    autoinstall_updates => true,
#  }
#
# === Authors
#
# Current Maintainer: mtron https://github.com/mtron
#
# Forked from: https://github.com/frenkel/frenkel-openup
# Original Author: Frank Groeneveld <https://github.com/frenkel>
#
# === Copyright
#
# Copyright (c) 2019, mtron
# Copyright (c) 2014, Frank Groeneveld
#

class openup (
  $openup_url          = 'https://stable.mtier.org/openup',
  $openbsd_mirror      = 'https://cdn.openbsd.org/pub/OpenBSD',
  $openbsd_mtier_url   = 'https://stable.mtier.org/updates',
  $openbsd_vul_db      = 'https://stable.mtier.org/vuxml',
  $owner               = $openup::params::openupuser,
  $group               = $openup::params::openupgroup,
  $mode                = '0755',
  $admin_email         = undef,
  $sender_email        = "openup@$::fqdn",
  $enable_cronjob      = false,
  $autoinstall_updates = false,
) inherits openup::params {

  class { 'openup::install': }
  -> class { 'openup::configure': }
}
