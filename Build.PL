use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Convert::Cisco',
    license             => 'perl',
    dist_author         => 'Mark O\'Connor <marko@cpan.org>',
    dist_version_from   => 'lib/Convert/Cisco.pm',
    build_requires => {
		'Log::Log4perl' => 0,
		'YAML::Syck' => 0,
		'DateTime' => 0,
		'XML::Writer' => 0,
		'Math::Round' => 0,
		'Test::Unit' => 0,
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Convert-Cisco-*' ],
);

$builder->create_build_script();
