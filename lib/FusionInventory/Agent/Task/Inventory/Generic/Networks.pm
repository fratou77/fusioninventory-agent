package FusionInventory::Agent::Task::Inventory::Generic::Networks;

use strict;
use warnings;

sub isEnabled {
    my (%params) = @_;
    return 0 if $params{no_category}->{network};
    return 1;
}

sub doInventory {}

1;
