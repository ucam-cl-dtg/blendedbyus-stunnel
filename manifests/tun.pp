define stunnel::tun(
	$conf_dir		= $stunnel::data::conf_dir,
	$certs_dir		= $stunnel::data::certs_dir,

	$protocol		= 'proxy',
	$ssl_version	= 'TLSv1',
	$client			= false,

	$user			= 'stunnel4',
	$group			= 'stunnel4',
	$pid			= "/var/run/stunnel4/${name}.pid",
	$chroot			= false,

	$debuglevel			= '0',
	$output			= "/var/log/stunnel4/${name}.log",

	$verify			= false,
	$cert			= false,
	$key			= false,
	$cafile			= false,
	$crlfile		= false,
	
	$connect		= false,
	
	$chroot			= false,
	$services,
) {
  validate_re($ssl_version, '^SSLv2$|^SSLv3$|^TLSv1$',
    'The option ssl_version must have a value that is either SSLv2, SSLv3, of TLSv1. The default and prefered options is TLSv1.')
  file { "${conf_dir}/${name}.conf":
    ensure  => file,
    content => template("${module_name}/stunnel.conf.erb"),
    mode    => '0644',
    owner   => '0',
    group   => '0',
    require => File[$conf_dir],
  }

}
