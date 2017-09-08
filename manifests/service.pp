# Enable the phpfpm service
class phpfpm::service ($ensure = running) {

  if ($ensure == running) {
    $enable = true
  } else {
    $enable = false
  }

  service { $phpfpm::service:
    ensure => $ensure,
    enable => $enable,
  }

}
