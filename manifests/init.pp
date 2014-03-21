# == Class: phpfpm
#
# Installs and configures PHP-FPM
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { phpfpm:  }
#
# === Authors
#
# Author Name <sam@bashton.com>
#
# === Copyright
#
# Copyright 2013-2014 Bashton Ltd
#
class phpfpm (
  $listen                 = '127.0.0.1:9000',
  $listen_backlog         = '-1',
  $listen_allowed_clients = '127.0.0.1',
  $max_children           = 50,
  $start_servers          = 5,
  $min_spare_servers      = 5,
  $max_spare_servers      = 10,
  $max_requests           = 500,
  $max_open_files         = 16384,
  $slow_time              = 0,
  $status_path            = undef,
  $ping_path              = undef,
  $limit_extensions       = '.php',
  $ensure                 = 'present',
  $php_admin              = {},
  $php_flag               = {},
  $php_value              = {},
  $apc                    = false,
  $user                   = $phpfpm::params::user,
  $package                = $phpfpm::params::package,
  $apcpackage             = $phpfpm::params::apcpackage,
  $service                = $phpfpm::params::service,
  $config                 = $phpfpm::params::config
  ) inherits params {


  $serviceensure = $ensure ? {
    'present' => 'running',
    'absent'  => 'stopped'
  }

  class { 'phpfpm::install': } ->
  class { 'phpfpm::config':
    ensure      => $ensure,
    config_file => $config,
  } ~>
  class { 'phpfpm::service':
    ensure => $serviceensure,
  }

  if ($apc) {
    class { 'phpapc':
      # require => Class['phpfpm::install'],
      # notify  => Class['phpfpm::service'],
    }
  }
}
