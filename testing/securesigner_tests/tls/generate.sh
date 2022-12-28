#!/bin/bash
openssl req -x509 -sha256 -nodes -days 36500 -newkey rsa:4096 -keyout securesigner/key.key -out securesigner/cert.pem -config securesigner/config &&
openssl pkcs12 -export -out securesigner/key.p12 -inkey securesigner/key.key -in securesigner/cert.pem -password pass:$(cat securesigner/password.txt) &&
cp securesigner/cert.pem lighthouse/securesigner.pem &&
openssl req -x509 -sha256 -nodes -days 36500 -newkey rsa:4096 -keyout lighthouse/key.key -out lighthouse/cert.pem -config lighthouse/config &&
openssl pkcs12 -export -out lighthouse/key.p12 -inkey lighthouse/key.key -in lighthouse/cert.pem -password pass:$(cat lighthouse/password.txt) &&
openssl x509 -noout -fingerprint -sha256 -inform pem -in lighthouse/cert.pem | cut -b 20-| sed "s/^/lighthouse /" > securesigner/known_clients.txt
