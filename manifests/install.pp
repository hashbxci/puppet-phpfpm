# Install the PHPFPM package
class phpfpm::install {

  package { $::phpfpm::package:
    ensure => $::phpfpm::ensure,
  }
}
