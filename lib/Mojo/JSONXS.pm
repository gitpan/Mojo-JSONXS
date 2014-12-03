use strict;
use warnings;
package Mojo::JSONXS;

# ABSTRACT: provide faster JSON for Mojolicious apps using Cpanel::JSON::XS


use Cpanel::JSON::XS;
use Mojo::JSON;
use Mojo::Util 'monkey_patch';

my $BINARY = Cpanel::JSON::XS->new->utf8(1)->allow_nonref(1)->allow_blessed(1)->convert_blessed(1);
my $TEXT = Cpanel::JSON::XS->new->utf8(0)->allow_nonref(1)->allow_blessed(1)->convert_blessed(1);

monkey_patch 'Mojo::JSON', 'encode_json', sub { $BINARY->encode(shift) };
monkey_patch 'Mojo::JSON', 'decode_json', sub { $BINARY->decode(shift) };

monkey_patch 'Mojo::JSON', 'to_json',   sub { $TEXT->encode(shift) };
monkey_patch 'Mojo::JSON', 'from_json', sub { $TEXT->decode(shift) };

monkey_patch 'Mojo::JSON', 'true()',  sub { Cpanel::JSON::XS::true() };
monkey_patch 'Mojo::JSON', 'false()', sub { Cpanel::JSON::XS::false() };

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Mojo::JSONXS - provide faster JSON for Mojolicious apps using Cpanel::JSON::XS

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  use Mojolicious;
  use Mojo::JSONXS;

  ...

=head1 SEE ALSO

  * Cpanel::JSON::XS
  * Mojolicious
  * https://groups.google.com/forum/?fromgroups=#!topic/mojolicious/a4jDdz-gTH0

=head1 AUTHOR

Jeremy Zawodny <Jeremy@Zawodny.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Jeremy Zawodny.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
