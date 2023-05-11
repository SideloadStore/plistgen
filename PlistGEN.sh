#!/bin/bash
# 
# 2023 SideloadStore Team (originaly created by Kyle Brooks 2014)
#
# This is an updated Shell script to generate PLISTS for OTA installs
# Feel free to modify and update as needed as OTA installs can change
# 
# generate-plist.sh
# iOS Enterprise Distribution P-List Generator
#
# If any of the required arguments are not passed, a prompt will be provided to enter them.
# 
# Arguments:
# 1: title (ex. My Awesome App)
# 2: bundle-version (ex. 1.0.0)
# 3: bundle-identifier (ex. com.kylewbanks.AwesomeApp) 
# 4: url (ex. https://kylewbanks.com/AwesomeApp.ipa)
# 5: output-file (ex. ~/MyApp.plist) [Optional: By default, outputs to the console.]
# 
# Example:
# ./generate-plist.sh "My Awesome App" 1.0.0 com.kylewbanks.AwesomeApp https://kylewbanks.com/AwesomeApp.ipa ~/MyApp.plist

# Capture command line args, or prompt for input if not set
TITLE=$1
if [ -z "${TITLE}" ]
then
    read -p "title: " TITLE
fi

BUNDLE_VERSION=$2
if [ -z "${BUNDLE_VERSION}" ]
then
    read -p "bundle-version: " BUNDLE_VERSION
fi

BUNDLE_IDENTIFIER=$3
if [ -z "${BUNDLE_IDENTIFIER}" ]
then
    read -p "bundle-identifier: " BUNDLE_IDENTIFIER
fi

URL=$4
if [ -z "${URL}" ]
then
    read -p "url: " URL
fi

URL_IMAGE=$5
if [ -z "${URL_IMAGE}" ]
then
    read -p "url_image: " URL_IMAGE
fi

# Generate the P-List
read -r -d '' PLIST << EndOfPlist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
					<string>$URL</string>
				</dict>
				<dict>
					<key>kind</key>
					<string>display-image</string>
					<key>url</key>
					<string>$URL_IMAGE</string>
				</dict>
				<dict>
					<key>kind</key>
					<string>full-size-image</string>
					<key>url</key>
					<string>$URL_IMAGE</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<string>$BUNDLE_IDENTIFIER</string>
				<key>bundle-version</key>
				<string>$BUNDLE_VERSION</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>$TITLE</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>

EndOfPlist

# Determine what to do with the P-List (Output to console or write to file)
OUTPUT=$6
if [ -z "${OUTPUT}" ]
then
	echo "$PLIST"
else
	echo "$PLIST" >> $OUTPUT
fi
