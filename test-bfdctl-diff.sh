#!/bin/sh

expected=$1
actual=$2
shift 2

clean() {
    sed -r 's/"downtime":[0-9]+/"downtime":0/' $1
}

diff -u "$@" <(clean "$expected")  <(clean "$actual")
