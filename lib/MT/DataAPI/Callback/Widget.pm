# Movable Type (r) (C) 2001-2020 Six Apart Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package MT::DataAPI::Callback::Widget;

use strict;
use warnings;

sub save_filter {
    my ( $eh, $app, $obj, $orig ) = @_;

    if ( !defined( $obj->name ) || $obj->name eq '' ) {
        return $app->errtrans( 'A parameter "[_1]" is required.', 'name' );
    }

    if ( ( $obj->type || '' ) ne 'widget' ) {
        return $app->errtrans( 'Invalid type: [_1]', $obj->type );
    }

    return 1;
}

1;

__END__

=head1 NAME

MT::DataAPI::Callback::Widget - Movable Type class for Data API's callbacks about the Widget (MT::Template).

=head1 AUTHOR & COPYRIGHT

Please see the I<MT> manpage for author, copyright, and license information.

=cut
