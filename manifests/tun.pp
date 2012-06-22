define stunnel::tun(
	$protocol		= 'proxy',
	$ssl_version	= 'all',
	$client			= false,

	$user			= 'stunnel4',
	$group			= 'stunnel4',
	$pid			= "/var/run/stunnel4/${name}.pid",
	$chroot			= false,

	$debug			= '0',
	$output			= "/var/log/stunnel4/${name}.log",

	$verify			= false,
	$cert,
	$key			= false,
	$CAFile			= false,
	$CRLFile		= false,
	$connect		= false,
	$conf_dir		= $stunnel::data::conf_dir,
	
	$chroot			= false,
	$services,
) {

  file { "${conf_dir}/${name}.conf":
    ensure  => file,
    content => template("${module_name}/stunnel.conf.erb"),
    mode    => '0644',
    owner   => '0',
    group   => '0',
    require => File[$conf_dir],
  } 

  file { $chroot:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0600',
  }

}