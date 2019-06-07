#!/bin/bash

set -e

HOST_FILE="hosts"
HOST_FILE_TO_CHECK="hosts2"

echo "Looking for adb devices.."
adb devices 
echo "Remounting.."
adb remount
echo "Downloading hosts file from https://adaway.org/hosts.txt"
wget -4 -c https://adaway.org/hosts.txt -O $HOST_FILE
echo "Pushing hosts file to a device"
adb push $HOST_FILE /system/etc/
echo "Check if the upload was successful"
adb pull /system/etc/$HOST_FILE $HOST_FILE_TO_CHECK
cmp --silent $HOST_FILE $HOST_FILE_TO_CHECK && echo "Files are identical!" || (echo "Filles differ !!"; exit 1;)
echo "Cleanup"
rm $HOST_FILE_TO_CHECK $HOST_FILE
echo "Success"