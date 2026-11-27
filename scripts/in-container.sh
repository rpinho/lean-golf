#!/bin/sh
set -eu

cmp /source/lean-toolchain /opt/lean-golf/lean-toolchain
cmp /source/lake-manifest.json /opt/lean-golf/lake-manifest.json
mkdir /work/home /work/project
export HOME=/work/home
cp -R /source/. /work/project/
cd /work/project
mkdir .lake
ln -s /opt/lean-golf/.lake/packages .lake/packages
lake build golfcheck >&2
exec lake exe golfcheck "theorems/$1" /Submission.lean
