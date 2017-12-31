#!/usr/bin/env bash


eval "export $(resize | grep 'COLUMNS=')"
expand | cut -c-$COLUMNS
