lftp -u ftp4904139,$RENLABUS sftp://11d16b2.netsolhost.com << 'EOF'
set sftp:auto-confirm yes
mirror -R --verbose ./ /htdocs/
bye
EOF
