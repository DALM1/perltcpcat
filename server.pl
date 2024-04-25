#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;


my $adresse = '127.0.0.1';
my $port = 8080;


my $serveur = IO::Socket::INET->new(
    LocalAddr => $adresse,
    LocalPort => $port,
    Proto => 'tcp',
    Listen => SOMAXCONN,
    Reuse => 1
) or die "Impossible de créer le serveur : $!\n";

print "Serveur de chat démarré sur $adresse:$port\n";


while (1) {
    my $client = $serveur->accept();
    my $client_address = $client->peerhost();
    my $client_port = $client->peerport();
    print "Connexion établie avec $client_address:$client_port\n";

   
    my $pid = fork();
    die "Impossible de créer un processus enfant : $!" unless defined $pid;

    if ($pid == 0) { 
        $serveur->close(); 


        while (my $message = <$client>) {
            print "[$client_address:$client_port] : $message";
            print "Message: ";
        }

        $client->close();
        exit; 
    } else {
        $client->close(); 
    }
}


$serveur->close();
