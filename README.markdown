What is this?
=============

Derived from the original puppetlabs-stunnel here this version allows multiple service blocks that will allow multiple 
certificates to be run on a single port (multiple ip addresses) indirectly removing the need for running multiple stunnel 
instances. Please verify that your stunnel version supports this.

I've also remove much of the obfuscation of the parameters since I prefer them to correlate with
the stunnel parameters directly.

Usage
=============

The following are for use inside of the node or service block.

Multiple IP Addresses same destination
--------------------------------------

### Configuration (site.pp)
    include stunnel
    Stunnel::Tun {
            require => Package[$stunnel::data::package],
            notify => Service[$stunnel::data::service],
    }

    stunnel::tun { 'https':
            connect => '127.0.0.1:81',
            services => {
                    'site.com' => {  accept => '1.1.1.1' },
                    'othersite.com' => { accept => '2.2.2.2' },
            }
    }

### Certificates

Certificates are stored in the /modules/stunnel/files directory by default copied to /etc/stunnel/certs.

### Output

Please note that ruby 1.8 does not order hashes so your services will be in some random order most likely.

**/etc/stunnel/https.conf**

    ; This stunnel config is managed by Puppet.
    protocol = proxy
    sslVersion = all

    setuid = stunnel4
    setgid = stunnel4
    pid = /var/run/stunnel4/https.pid

    socket = l:TCP_NODELAY=1
    socket = r:TCP_NODELAY=1
    TIMEOUTclose = 0

    debuglevel = 0
    output = /var/log/stunnel4/https.log

    [othersite.com]
    accept = 2.2.2.2
    connect = 127.0.0.1:81
    cert = /etc/stunnel/certs/site.com.pem

    [site.com]
    accept = 1.1.1.1
    connect = 127.0.0.1:81
    cert = /etc/stunnel/certs/othersite.com.pem

**/etc/stunnel/certs**

    -rw------- 1 root root 8206 Jun 27 12:36 site.com.pem
    -rw------- 1 root root 8227 Jun 27 12:36 othersite.com.pem
