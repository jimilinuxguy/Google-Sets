#!/usr/bin/perl

package GoogleSets;
use strict;
use LWP::Simple;
use HTML::TableExtract;


sub new
{
    my $self=shift;
    my $class=ref($self) || $self;
    return bless {}, $class;
}

sub fetch  {

	my $self = shift; 
	my @set = @_;

	my $url = 'http://labs.google.com/sets?hl=en';

	for (my $i = 0; $i < length(@set); $i++)
	{
		my $j = $i + 1;
		$url .= '&q'.$j.'='.$set[$i];
	}

	$url .='&btn=Small+Set+(15+items+or+fewer)';

	my $html = get $url;


	my $te = HTML::TableExtract->new( depth => 1, count => 0);
	$te->parse($html);


	my @elements = ();
	foreach my $ts ($te->tables) {
		foreach my $row ($ts->rows) {
			my $thing =  join(',',@$row);

			if ( $thing =~ /Predicted/)
			{
				next;
			}

			push(@elements,$thing);
		}
	}


	return @elements;
}


1;
