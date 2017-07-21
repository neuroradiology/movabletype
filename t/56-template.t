#!/usr/bin/perl

use strict;
use warnings;

use lib 'extlib', 'lib', 't/lib';

use MT::Test;
use Test::More;
use MT::Template;

use MT::App::CMS;
my $app = MT->new;

{
    note('getElementsByName:');

    my $tmpl = MT::Template->new_string( \<<__TMPL__);
    <mt:include name="include/header.tmpl" />

    <mt:include name="include/actions_bar.tmpl" />

    Contents

    <mt:include name="include/actions_bar.tmpl" />

    <mt:include name="include/footer.tmpl" />
__TMPL__

    my %map = (
        'include/header.tmpl'      => 1,
        'include/actions_bar.tmpl' => 2,
        'not_included'             => undef,
    );

    for my $name ( sort keys %map ) {
        my $expected = $map{$name};
        my $elms     = $tmpl->getElementsByName($name);
        if ( defined($expected) ) {
            is( scalar @$elms, $expected, qq(for "$name" is $expected) );
        }
        else {
            is( $elms, undef, qq(for "$name" is undef) );
        }
    }
}

done_testing();
