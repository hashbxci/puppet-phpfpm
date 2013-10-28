# Params for PHP FPM
class phpfpm::params {

  $package = $::osfamily ? {
    'Debian' => 'php5-fpm',
    default  => 'php-fpm'
  }

  $service = $package

  $user = $::osfamily ? {
    'Debian' => 'www-data',
    default => 'apache'
  }

  $config = $::osfamily ? {
    default => '/etc/php-fpm.d/www.conf'
  }
}
