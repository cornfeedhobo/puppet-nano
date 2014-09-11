class nano::config (
  $exclude       = $::nano::params::exclude,
  $casesensitive = $::nano::params::casesensitive,
  $const         = $::nano::params::const,
  $cut           = $::nano::params::cut,
  $morespace     = $::nano::params::morespace,
  $noconvert     = $::nano::params::noconvert,
  $nohelp        = $::nano::params::nohelp,
  $nonewlines    = $::nano::params::nonewlines,
  $nowrap        = $::nano::params::nowrap,
  $regexp        = $::nano::params::regexp,
  $smarthome     = $::nano::params::smarthome,
  $smooth        = $::nano::params::smooth,
  $tabsize       = $::nano::params::tabsize,
  $tabstospaces  = $::nano::params::tabstospaces) inherits ::nano::params {
  unless $tabsize == undef {
    validate_re($tabsize, '^[1-8]$')
  }

  if is_array($exclude) {
    $ignore = suffix($exclude, '.nanorc')
    $includes = difference($highlights, $exclude)
  } else {
    $ignore = ''
    $includes = $highlights
  }

  file { '/usr/share/nano':
    ensure  => 'directory',
    recurse => 'remote',
    source  => "puppet:///modules/${module_name}/highlights",
    ignore  => $ignore
  }

  # Generate the nanorc configuration file
  file { '/etc/nanorc':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nanorc.erb")
  }
}
