use strict;
use warnings;
use Test::More;

use Dist::Zilla::Tester;

my %confs = (
	't/ini-none' => undef,
	't/ini-sep'  => {
		'argument_separator'  => '^([^|]+)\|([^|]+)$',
		_config => {
			'-PlugName|Attr::Name' => 'oops',
			'+Mod::Name|!goo-ber'  => 'nuts',
		}
	},
	't/ini-test' => {
		'argument_separator'  => '^(.+?)\W+(\w+)$',
		_config => {
			'@ABundle-fakeattr'    => 'fakevalue1',
			'-APlugin/fakeattr'    => 'fakevalue2',
			'ASection->heading'    => 'head5',
			'-APlug::Name::config' => 'confy',
		}
	}
);

plan tests => (scalar keys %confs);

foreach my $dir ( keys %confs ){

	my $zilla = Dist::Zilla::Tester->from_config(
		{ dist_root => $dir },
		{}
	);

	$zilla->build;

	is_deeply($zilla->stash_named('%PodWeaver'), $confs{$dir}, "stash matches in $dir");
}
