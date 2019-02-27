#!/usr/bin/env bash
# Based on: http://godlessheathenmemoirs.blogspot.com.au/2015/03/homebrew-aka-brew-on-mac-os-x-behind.html

function usage() {
  echo 2>&1 ""
  echo 2>&1 "usage: $(basename $0) PROXY_HOST PROXY_PORT"
  exit 1
}

PROXY_HOST=${PROXY_HOST:-$1}
PROXY_PORT=${PROXY_PORT:-$2}

[ -z "${PROXY_HOST}" ] && { echo 1>&2 "PROXY_HOST not defined"; usage; }
[ -z "${PROXY_PORT}" ] && { echo 1>&2 "PROXY_PORT not defined"; usage; }

PROXY_URI=${PROXY_HOST}:${PROXY_PORT}

# export proxy environment configurations
declare -x HTTPS_PROXY="http://${PROXY_URI}"
declare -x HTTP_PROXY="http://${PROXY_URI}"
declare -x http_proxy="http://${PROXY_URI}"
declare -x https_proxy="http://${PROXY_URI}"

# ignore TLS issues when cloning from git (homebrew)
declare -x GIT_SSL_NO_VERIFY="1"

# there really should be a better way; sigh
# source: https://brew.sh/
ruby -e "$(curl -x http://${PROXY_URI} -fsSL -k https://raw.githubusercontent.com/Homebrew/install/master/install)"
