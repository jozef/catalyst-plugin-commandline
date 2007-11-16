package Catalyst::Plugin::CommandLine;

=head1 NAME

Catalyst::Plugin::CommandLine - Catalyst plugin to make $c available also for scripts.

=head1 SYNOPSIS

	# in MyCatalystApp.pm
	use Catalyst qw( CommandLine );

	# in a script
	use MyCatalystApp;

	my $c = MyCatalystApp->commandline;
	
	$c->stash->{ ...
	$c->model( ...
	$c->controller( ...
	$c->view( ...

=head1 DESCRIPTION

Use this module if you need to have access to the Catalyst controllers or models from
command line script.

=cut

use base qw/Class::Data::Inheritable/;

use strict;
use warnings;

use NEXT;
use UNIVERSAL qw{ can };
use HTTP::Headers;
use Catalyst::Request;
use Catalyst::Response;
use URI::http;

our $VERSION = "0.04";

=head1 FUNCTIONS

=head2 commandline

Will setup $c so that it could be used in the script.

Setups stash, request, response, sessionid.

=cut

sub commandline {
    my $class;
    my $c;

	# if called as constructor then contruct the object
    if (ref $_[0] eq '') {
    	$class = shift;
    	$c = $class->new();
    }
    # otherwise get "$self"
    else {
	    $c = shift;
	    
	    # prevent reinitializing
	    return $c if $c->commandline_mode;
    }
    
	my $uri_path = '/';
	my $uri = \$uri_path;
	bless $uri, 'URI::http';

	my $base = \$c->config->{'base'};
	bless $base, 'URI::http';

	$c->stash({ CommandLine => 1 });
	$c->request(Catalyst::Request->new({
		'cookies' => {},
		'base'    => $base,
		'uri'     => $uri,
		'secure'  => 1,
	}));
	$c->response(Catalyst::Response->new({
		'cookies' => {},
		'headers' => HTTP::Headers->new,
	}));

	# execute the root auto method
	$c->controller('Root')->auto($c);
	
	return $c;
}


=head2 commandline_mode

Returns true/false if catalyst is running in commandline mode.

=cut

sub commandline_mode {
	my $c = shift;
	
	return 1 if ($c->stash and $c->stash->{'CommandLine'});
	return 0;
}

1;

=head1 AUTHOR

Jozef Kutej - E<lt>jozef@kutej.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Jozef Kutej

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
