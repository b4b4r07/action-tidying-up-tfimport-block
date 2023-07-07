#!/bin/bash

import_file=import.tf

state="${INPUT_STATE:?need state list input}"

hcl2json ${import_file} | jq -r '.import[].to' | while read -r line; do
resource_addr="${line:2:${#line}-2-1}"
if ! echo "${state}"| grep -q -w "${resource_addr}"; then
  # Import block target does not exist
  echo "Import block target does not exist: ${resource_addr}"
  echo "error=true" >> "${GITHUB_OUTPUT}"
fi
done
