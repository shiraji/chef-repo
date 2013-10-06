#!/bin/sh

if [ $# -ne 1 ]; then
  echo "No role name"
  exit 1
fi

_role_name=$1

cat role_template.json | sed -e "s/NAME/${_role_name}/g" > ./${_role_name}.json
