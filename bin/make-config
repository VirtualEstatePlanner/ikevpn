#!/bin/bash

[ "no${HOST}" = "no" ] && echo "\$HOST environment variable required." && exit 1

[ "no${PROFILE_NAME}" = "no" ] && echo "\$PROFILE_NAME environment variable required." && exit 1

[ "no${CONN_NAME}" = "no" ] && echo "\$CONN_NAME environment variable required." && exit 1

: ${PROFILE_IDENTIFIER=$(echo -n "${HOST}." | sed 's/\.$//g')}
: ${PROFILE_UUID=$(hostname)}
: ${CONN_IDENTIFIER="${PROFILE_IDENTIFIER}.shared-configuration"}
: ${CONN_UUID=$(uuidgen)}
: ${CONN_HOST=${HOST}}
: ${CONN_REMOTE_IDENTIFIER=${HOST}}

CONN_SHARED_SECRET=$(cat /etc/ipsec.secrets | sed 's/.*"\(.*\)"/\1/g')

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>PayloadDisplayName</key>
        <string>${PROFILE_NAME}</string>
        <key>PayloadIdentifier</key>
        <string>${PROFILE_IDENTIFIER}</string>
        <key>PayloadUUID</key>
        <string>${PROFILE_UUID}</string>
        <key>PayloadType</key>
        <string>Configuration</string>
        <key>PayloadVersion</key>
        <integer>1</integer>
        <key>PayloadContent</key>
        <array>
            <dict>
                <key>PayloadIdentifier</key>
                <string>${CONN_IDENTIFIER}</string>
                <key>PayloadUUID</key>
                <string>${CONN_UUID}</string>
                <key>PayloadType</key>
                <string>com.apple.vpn.managed</string>
                <key>PayloadVersion</key>
                <integer>1</integer>
                <key>UserDefinedName</key>
                <string>${CONN_NAME}</string>
                <key>VPNType</key>
                <string>IKEv2</string>
                <key>IKEv2</key>
                <dict>
                    <key>RemoteAddress</key>
                    <string>${CONN_HOST}</string>
                    <key>RemoteIdentifier</key>
                    <string>${CONN_REMOTE_IDENTIFIER}</string>
                    <key>LocalIdentifier</key>
                    <string></string>
                    <key>OnDemandEnabled</key>
                    <integer>0</integer>
                    <key>OnDemandRules</key>
                    <array>
                        <dict>
                            <key>Action</key>
                            <string>Connect</string>
                        </dict>
                    </array>
                    <key>AuthenticationMethod</key>
                    <string>SharedSecret</string>
                    <key>SharedSecret</key>
                    <string>${CONN_SHARED_SECRET}</string>
                    <key>ExtendedAuthEnabled</key>
                    <integer>0</integer>
                    <key>AuthName</key>
                    <string></string>
                    <key>AuthPassword</key>
                    <string></string>
                    <key>IKESecurityAssociationParameters</key>
                    <dict>
                        <key>EncryptionAlgorithm</key>
                        <string>AES-256</string>
                        <key>IntegrityAlgorithm</key>
                        <string>SHA2-256</string>
                        <key>DiffieHellmanGroup</key>
                        <integer>14</integer>
                    </dict>
                    <key>ChildSecurityAssociationParameters</key>
                    <dict>
                        <key>EncryptionAlgorithm</key>
                        <string>AES-256</string>
                        <key>IntegrityAlgorithm</key>
                        <string>SHA2-256</string>
                        <key>DiffieHellmanGroup</key>
                        <integer>14</integer>
                    </dict>
                </dict>
            </dict>
        </array>
    </dict>
</plist>
EOF
