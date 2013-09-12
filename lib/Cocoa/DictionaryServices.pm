package Cocoa::DictionaryServices;
use 5.008005;
use strict;
use warnings;
use parent qw/Exporter/;

our $VERSION = "0.01";

our @EXPORT_OK = qw/lookup available_dictionaries/;

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

1;
__END__

=encoding utf-8

=head1 NAME

Cocoa::DictionaryServices - Perl interface to Dictionary Services

=head1 SYNOPSIS

    use Cocoa::DictionaryServices qw/lookup/;
    print lookup('hello');

=head1 DESCRIPTION

Cocoa::DictionaryServices is ...

=head1 FUNCTIONS

=over 4

=item C<< lookup($word, [$dictionary]) >>

=item C<< available_dictionaries() >>

=back

=head1 LICENSE

Copyright (C) Takumi Akiyama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym@gmail.comE<gt>

=cut

