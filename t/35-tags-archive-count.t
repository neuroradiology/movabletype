#!/usr/bin/perl

use strict;
use warnings;

use lib qw(lib t/lib);

BEGIN {
    $ENV{MT_CONFIG} = 'mysql-test.cfg';
}

use MT::Test::Tag;
plan tests => 2 * blocks;

use MT;
use MT::Test qw(:db);
use MT::Test::Permission;
my $app = MT->instance;

my $blog_id = 1;

filters {
    template => [qw( chomp )],
    expected => [qw( chomp )],
};

my $mt = MT->instance;

my $blog = MT::Blog->load($blog_id);
$blog->archive_type('Page,Individual,Category,Monthly');
$blog->save or die $blog->errstr;

my $category = MT::Test::Permission->make_category( blog_id => $blog_id, );

my $entry_new = MT::Test::Permission->make_entry(
    blog_id     => $blog_id,
    authored_on => '20150101000000',
);
$entry_new->attach_categories($category);

my $entry_old = MT::Test::Permission->make_entry(
    blog_id     => $blog_id,
    authored_on => '20130101000000',
);
$entry_old->attach_categories($category);

MT::Test::Tag->run_perl_tests($blog_id);
MT::Test::Tag->run_php_tests($blog_id);

__END__

=== MTArchiveCount
--- template
<MTCategories>
<MTArchiveList archive_type='Category-Yearly'><MTArchiveTitle>: <MTArchiveCount>
</MTArchiveList>
</MTCategories>
--- expected
2015: 1
2013: 1
