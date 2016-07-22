#!/bin/bash

dd if=/dev/zero of=/swap bs=1M count=512

mkswap /swap

chmod 0600 /swap

swapon /swap