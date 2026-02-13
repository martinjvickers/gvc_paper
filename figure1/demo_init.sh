#!/usr/bin/env bash

cmd () {
    echo -e "\033[1;32m$ $1\033[0m"
    sleep 0.5
}

out () {
    echo "$1"
    sleep 0.5
}

clear
sleep 0.6

cmd "gvc init scaffolds.fa --name Pisum sativum JI2822"
out "Commit Message : nanopore ultralong hifiasm"
out "repo initialised - 5DHS27G"

cmd "gvc commit hic_scaffolded.fa"
out "Commit Message : Assembled scaffolds.fa using hiC data"
out "updated assembly - F98ASWQ"

cmd "gvc annotate genes.gff --on main"
out "Commit Message : liftoff using Cameor v1a"
out "annotation attached to F98ASWQ"

cmd "gvc commit improved_scaffold.fa --on main"
out "updated assembly - TWXFR8A"
out "WARNING - 24 merge conflicts in annotation"
out "TWXFR8A will not be pushed to main until resolved"
out "Use gvc diff to view and manually resolve"
out "Run gvc recommit TWXFR8A once resolved"

cmd "gvc export genome+annotation"
out "Pisum_sativum_JI2822_F98ASWQ.fa written out"
out "Pisum_sativum_JI2822_F98ASWQ.gff3 written out"
echo;