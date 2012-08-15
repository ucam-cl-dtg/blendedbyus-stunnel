node default {
  include stunnel
  Stunnel::Tun {
    require => Package[$stunnel::data::package],
    notify => Service[$stunnel::data::service],
  }
  stunnel::tun { 'rsyncd':
    cert => "/etc/puppet/ssl/certs/${::clientcert}.pem",
    key => "/etc/puppet/ssl/private_keys/${::clientcert}.pem",
    cafile     => '/etc/puppet/ssl/certs/ca.pem',
    crlfile    => '/etc/puppet/ssl/crl.pem',
    chroot      => '/var/lib/stunnel4/rsyncd',
    user        => 'puppet',
    group       => 'puppet',
    client      => false,
    services    => {'test' => { accept => '1873'}},
    connect     => '873',
  }
  stunnel::tun { 'rsync':
    cert => "/etc/puppet/ssl/certs/${::clientcert}.pem",
    key => "/etc/puppet/ssl/private_keys/${::clientcert}.pem",
    cafile     => '/etc/puppet/ssl/certs/ca.pem',
    crlfile    => '/etc/puppet/ssl/crl.pem',
    chroot      => '/var/lib/stunnel4/rsync',
    user        => 'puppet',
    group       => 'puppet',
    client      => true,
    services    => {'test1' => { accept => '1874'}},
    connect     => 'server.example.com:1873',
  }
}
