#!/bin/bash

SKEL="/etc/openvpn/client-skel.txt"
OUTDIR="~/vpn"
EASYRSA_DIR="/etc/openvpn/easy-rsa"

newclient () {
	mkdir -p "$OUTDIR"
	# Generates the custom client.ovpn
	cp "$SKEL" "$OUTDIR/$1.ovpn"
	echo "<ca>" >> "$OUTDIR/$1.ovpn"
	cat "$EASYRSA_DIR/pki/ca.crt" >> "OUTDIR/$1.ovpn"
	echo "</ca>" >> "$OUTDIR/$1.ovpn"
	echo "<cert>" >> "$OUTDIR/$1.ovpn"
	cat "$EASYRSA_DIR/pki/issued/$1.crt" >> "$OUTDIR/$1.ovpn"
	echo "</cert>" >> "$OUTDIR/$1.ovpn"
	echo "<key>" >> "$OUTDIR/$1.ovpn"
	cat "$EASYRSA_DIR/pki/private/$1.key" >> "$OUTDIR/$1.ovpn"
	echo "</key>" >> "$OUTDIR/$1.ovpn"
	echo "<tls-auth>" >> "$OUTDIR/$1.ovpn"
	cat /etc/openvpn/server/ta.key >> "$OUTDIR/$1.ovpn"
	echo "</tls-auth>" >> "$OUTDIR/$1.ovpn"
}

if [ ! -z "$1" ]; then
    newclient "$1"
fi

