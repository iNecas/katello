#!/usr/bin/env bash

function kk () { katello -u admin -p admin "$@"; }

function product-create () {
  org=$1
  prod=$2
  kk product create --org "${org}" --provider "${org}prov1" --name "${prod}"
  kk repo create --org "${org}" --product "${prod}" --name "base" --url "http://inecas.fedorapeople.org/fakerepos/new_cds/content/zoo/1.0/x86_64/rpms/"
  REPO_ID=$(kk repo info --org "${org}" --product "${prod}" --name "base" | grep ID | grep -o "[0-9]*")

  kk repo synchronize --id $REPO_ID
}

kk ping

ORG=$1
kk org create --name "${ORG}"
kk provider create --org "${ORG}" --name "${ORG}prov1"

product-create "$ORG" "${ORG}prov1prod1"
product-create "$ORG" "${ORG}prov1prod2"
kk content definition create --org "${ORG}" --name "${ORG}cvd1"
kk content definition add_product --org "${ORG}" --name "${ORG}cvd1" --product "${ORG}prov1prod1"
kk content definition add_product --org "${ORG}" --name "${ORG}cvd1" --product "${ORG}prov1prod2"
kk content definition publish --org "${ORG}" --name "${ORG}cvd1" --view_name "${ORG}cv1"
