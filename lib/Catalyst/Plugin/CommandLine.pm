package Catalyst::Plugin::CommandLine;

=head1 NAME

Catalyst::Plugin::CommandLine - Catalyst plugin to make $c available also for scripts.

=head1 SYNOPSIS

	use MyCatalystApp;

	my $c = MyCatalystApp->new('MyCatalystApp');
	$c->commandline;
	
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

our $VERSION = "0.02";

=head1 FUNCTIONS

=head2 commandline

Will setup $c so that it could be used in the script.

Setups stash, request, response, sessionid.

=cut

sub commandline {
    my ( $c, $class, $action ) = @_;

	$c->stash({ CommandLine => 1 });
	$c->request(Catalyst::Request->new({ cookies => {}, base => $c->config->{'base'} }));
	$c->response(Catalyst::Response->new({ cookies => {} }));
	
	#if we have session setup sessionid
	if (can($c, 'sessionid')) {
		$c->sessionid('".$0." ".$PID."');
	}
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
