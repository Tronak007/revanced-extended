#!/usr/bin/env bash

set -e

pr() { echo -e "\033[0;32m[+] ${1}\033[0m"; }
ask() {
	local y
	for ((n = 0; n < 3; n++)); do
		pr "$1"
		if read -r y; then
			if [ "$y" = y ]; then
				return 0
			elif [ "$y" = n ]; then
				return 1
			fi
		fi
		pr "Asking again..."
	done
	return 1
}

if [ ! -f ~/.rvmm_"$(date '+%Y%m')" ]; then
	pr "Setting up environment..."
	yes "" | pkg update -y && pkg install -y openssl git wget jq openjdk-17 zip
	: >~/.rvmm_"$(date '+%Y%m')"
fi

if [ -f build.sh ]; then cd ..; fi
if [ -d revanced-magisk-module ]; then
	pr "Checking for revanced-extended updates"
	git -C revanced-extended fetch
	if git -C revanced-extended status | grep -q 'is behind'; then
		pr "revanced-extended is not synced with upstream."
		pr "Cloning revanced-extended. config.toml will be preserved."
		cp -f revanced-extended/config.toml .
		rm -rf revanced-extended
		git clone https://github.com/AbakNacchan/revanced-extended --recurse --depth 1
		mv -f config.toml revanced-extended/config.toml
	fi
else
	pr "Cloning revanced-extended."
	git clone https://github.com/AbakNacchan/revanced-extended --recurse --depth 1
	sed -i '/^enabled.*/d; /^\[.*\]/a enabled = false' revanced-extended/config.toml
fi
cd revanced-extended
chmod +x build.sh build-termux.sh

if ask "Do you want to open the config.toml for customizations? [y/n]"; then
	nano config.toml
fi
if ! ask "Setup is done. Do you want to start building? [y/n]"; then
	exit 0
fi
./build.sh

cd build
pr "Ask for storage permission"
until
	yes | termux-setup-storage >/dev/null 2>&1
	ls /sdcard >/dev/null 2>&1
do
	sleep 1
done

PWD=$(pwd)
mkdir -p ~/storage/downloads/revanced-extended
for op in *; do
	[ "$op" = "*" ] && continue
	mv -f "${PWD}/${op}" ~/storage/downloads/revanced-extended/"${op}"
done

pr "Outputs are available in /sdcard/Download/revanced-extended folder"
am start -a android.intent.action.VIEW -d file:///sdcard/Download/revanced-extended -t resource/folder
sleep 2
am start -a android.intent.action.VIEW -d file:///sdcard/Download/revanced-extended -t resource/folder
