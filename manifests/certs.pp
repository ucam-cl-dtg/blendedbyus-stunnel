define stunnel::certs() {
	file { "${name}":
		path => "${stunnel::data::certs_dir}/${name}.pem",
		source => "puppet:///modules/stunnel/${name}.pem",
		owner => root,
		group => root,
		mode => 600
	}
}
