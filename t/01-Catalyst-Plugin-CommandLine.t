
use Test::More tests => 2;
BEGIN { use_ok('Catalyst::Plugin::CommandLine') };

can_ok('Catalyst::Plugin::CommandLine', 'commandline')