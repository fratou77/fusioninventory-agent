package Ocsinventory::Agent::Backend::OS::POSIX::Packaging::RPM;

use strict;
use warnings;

sub check {my $p = `which rpm`; $p}
#sub check {0}

sub run {
  my $params = shift;
  my $inventory = $params->{inventory};

  my @list;
  my $buff;
  foreach (`LANG=C rpm -qa --queryformat "%{NAME} %{VERSION}-%{RELEASE} %{SUMMARY}\n--\n"`) {
    if (! /^--/) {
      chomp;
      $buff .= $_;
    } elsif ($buff =~ s/^(\S+)\s+(\S+)\s+(.*)//) {
      $inventory->addSoftwares({
	  'NAME'          => $1,
	  'VERSION'       => $2,
	  'COMMENTS'      => $3,
	});
    } else {
	warn "Should never go here!";
	$buff = '';
    }
  }
}

1;
