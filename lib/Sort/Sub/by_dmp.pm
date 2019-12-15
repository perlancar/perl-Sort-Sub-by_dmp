package Sort::Sub::by_dmp;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Data::Dmp;

sub meta {
    return {
        v => 1,
        summary => 'Sort data structures by comparing their dump (using Data::Dmp)',
    };
}

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = @_ ? $_[0] : ${"$caller\::a"};
        my $b = @_ ? $_[1] : ${"$caller\::b"};

        my $cmp;

        # XXX cache

        my $dmp_a = dmp($a);
        my $dmp_b = dmp($b);

        $cmp = $is_ci ? lc($dmp_a) cmp lc($dmp_b) : $dmp_a cmp $dmp_b;
        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=head1 DESCRIPTION


=head1 ENVIRONMENT


=head1 prepend:SEE ALSO

L<Sort::Sub::data_struct_by_data_cmp>. Most of the time, you'd probably want
this instead.

L<Sort::Sub::by_perl_function>

L<Sort::Sub::by_perl_op>
