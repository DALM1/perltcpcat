#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;


my $adresse_serveur = '127.0.0.1';
my $port_serveur = 8080;


my $client = IO::Socket::INET->new(
    PeerAddr => $adresse_serveur,
    PeerPort => $port_serveur,
    Proto => 'tcp'
) or die "Impossible de se connecter au serveur : $!\n";

print "Connecté au serveur $adresse_serveur:$port_serveur\n";


while (1) {
    print "Message: ";
    my $message = <STDIN>;
    last unless defined $message; 
    $client->send($message);
}


$client->close();
