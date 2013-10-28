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
#  class { phpfpm:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Bashton Ltd
#
class phpfpm (
  $listen                 = '127.0.0.1:9000',
  $listen_backlog         = '-1',
  $listen_allowed_clients = '127.0.0.1',
  $max_children           = 50,
  $start_servers          = 5,
  $min_spare_servers      = 5,
  $max_spare_servers      = 5,
  $max_requests           = 0,
  $status_path            = undef,
  $ping_path              = undef,
  $limit_extensions       = '.php',
  $ensure                  = 'present'
  ) {

  include phpfpm::params
  $user = $phpfpm::params::user

  $serviceensure = $ensure ? {
    'present' => 'running',
    'absent'  => 'stopped'
  }

  package { $phpfpm::params::package:
    ensure => $ensure,
  }

  service { $phpfpm::params::service:
    ensure  => $serviceensure,
    require => Package[$phpfpm::params::package],
    enable  => true,
  }

  file { $phpfpm::params::config:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('phpfpm/www.conf.erb'),
    notify  => Service[$phpfpm::params::service],
    require => Package[$phpfpm::params::package],
  }
}
