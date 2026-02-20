rm -f pass.txt params.pem key.pem cert.pem

# openssl rand -hex 32 > pass.txt
# chmod 600 pass.txt

openssl ecparam -out params.pem -name prime256v1
openssl genpkey -paramfile params.pem -out key.pem
openssl req -new -x509 -key key.pem -config openssl.conf -days 365 -out cert.pem
