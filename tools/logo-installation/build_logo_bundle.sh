#! /usr/bin/env bash

logo_dir="TUDa-logos/"
bundle_name="TUDa_logo_bundle"
mecheng_bundle_name="TUDa_mecheng_logo_bundle"

rm -rf "$bundle_name" "$mecheng_bundle_name"
mkdir -p "$bundle_name"
cp -- "$logo_dir/tuda_logo.pdf" *.bat *.lua README.md "$bundle_name/."
zip -r "$bundle_name.zip" "$bundle_name"

cp -r "$bundle_name" "$mecheng_bundle_name"
cp "$logo_dir/"tuda_maschinenbau*.pdf "$mecheng_bundle_name/."
sed -i "s/# TU Darmstadt Logo Bundle/# TU Darmstadt Logo Bundle \(including mecheng logos\)/g" "$mecheng_bundle_name/"*.md
zip -r "$mecheng_bundle_name.zip" "$mecheng_bundle_name"
