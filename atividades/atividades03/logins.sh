grep -v 'sshd' auth.log
grep 'sshd.*Accepted password for j.*' auth.log
grep 'sshd.*Failed password for root' auth.log
grep -E '2025-09-29.*(Accepted|session opened)' auth.log
