#!/usr/bin/env bash
set -x

terraform -chdir=aws destroy -auto-approve 
rm -rf hosts
