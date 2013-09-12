use strict;
use warnings;
use utf8;
use Cocoa::DictionaryServices qw/lookup available_dictionaries/;
use Getopt::Long;

GetOptions(
    'd|dict=s' => \my $dictionary,
    'help'     => \&help,
);

my $word = shift or help();

my $result = lookup($word, $dictionary);
if (defined $result) {
    print $result;
} else {
    print "No entries found.\n";
    exit(1);
}

sub help {
    print <<"...";
Usage: $0 [-d=dictionary] word

available dictionaries:
    @{[ join ", ", available_dictionaries() ]}
...
    exit;
}
