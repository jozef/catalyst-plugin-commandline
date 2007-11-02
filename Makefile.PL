use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::Plugin::CommandLine',
    VERSION_FROM        => 'lib/Catalyst/Plugin/CommandLine.pm', # finds $VERSION
	PREREQ_PM           => {
		Class::Data::Inheritable => 0,
		Test::More               => 0,
		NEXT                     => 0,
		UNIVERSAL                => 0,
		HTTP::Headers            => 0,
		Catalyst::Request        => 0,
		Catalyst::Response       => 0,
		URI::http                => 0,
		English                  => 0,
	},
	($] >= 5.005 ?     ## Add these new keywords supported since 5.005
		(ABSTRACT_FROM  => 'lib/Catalyst/Plugin/CommandLine.pm', # retrieve abstract from module
		AUTHOR          => 'Jozef Kutej <jozef@kutej.net>') : ()),
	(MM->can('signature_target') ? (SIGN => 1) : ()),
);
