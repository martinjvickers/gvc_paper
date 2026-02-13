#!/usr/bin/env bash
# demo_gvc_conflicts.sh
# Fake terminal demo for compact conflict resolution in gvc

set -euo pipefail

cmd() { printf "\033[1;32m$ %s\033[0m\n" "$1"; sleep 0.55; }
out() { printf "%s\n" "$1"; sleep 0.45; }
blank() { echo; }

clear
sleep 0.4

cmd "gvc diff F98ASWQ..TWXFR8A --annotation"
out "CONFLICTS (24)  genes.gff3  (target: F98ASWQ → TWXFR8A)"
out "  C01 gene Psat.JI2822.v1.1g001400 spans scaffold split (scaffold_127:0.81Mb)"
out "  C01 mRNA Psat.JI2822.v1.1g001400.1.e4 exon crosses new gap"
out "  ..."
blank

cmd "gvc resolve --all --strategy liftover"
out "Resolved 23/24 automatically"
out "Remaining: C01 (exon overlaps new gap) → needs manual edit"
blank

cmd "gvc resolve C01"
out "gene Psat.JI2822.v1.1g001400:"
out "  old: scaffold_127:0.81Mb (+)   [F98ASWQ]"
out "  new: scaffold_17:3,198,440-3,200,000 (+)"
out "       scaffold_142:1-45,901 (+)             [TWXFR8A]"
out "Select fix: [1] split feature  [2] trim to left  [3] trim to right  [4] drop"
printf "> "
sleep 0.4
echo "1"
sleep 0.3
out "Commit message: Marked exon_3 as \"partial\" and adjusted end coordinate"
out "Saved: split gene + updated Parent/ID links"
blank

cmd "gvc recommit TWXFR8A -m \"Resolve 24 annotation conflicts after scaffold improvement\""
out "TWXFR8A pushed to main"
blank

cmd "gvc export genome+annotation"
out "Pisum_sativum_JI2822_TWXFR8A.fa written out"
out "Pisum_sativum_JI2822_TWXFR8A.gff3 written out"
blank