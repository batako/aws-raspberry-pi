#!/bin/sh

packer build -var-file=variables.pkrvars.hcl .
