# Configure PHP FPM
class phpfpm::config ($config_file, $ensure) {

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('phpfpm/www.conf.erb'),
  }

}
