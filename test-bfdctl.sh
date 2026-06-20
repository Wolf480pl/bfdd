#!/bin/sh

BFDCTL_BIN="$(dirname $0)/bfdctl"
SOCK=/tmp/bfdd/bfdd.sock
TEST_IP=192.168.16.1
TEST_LABEL="foo"

run() {
    echo ""
    echo "----" "$BFDCTL_BIN" -C "$SOCK" "$@"
    echo ""
    "$BFDCTL_BIN" -C "$SOCK" "$@"
}

run_tm() {
    run "$@" &
    pid=$!
    sleep 0.5
    kill $pid 2>/dev/null
}

echo ""
echo "======= NO  OP / NO MON ======="
run
run -m
run -m -p "$TEST_IP"
run -p "$TEST_IP"
run -L "$TEST_LABEL" -p "$TEST_IP"
run -L "$TEST_LABEL" -m -p "$TEST_IP"
run -L "$TEST_LABEL" -m
run -L foo

echo ""
echo "======= NO  OP /    MON ======="
run_tm -M
run_tm -M -m
run_tm -M -m -p "$TEST_IP"
run_tm -M -p "$TEST_IP"
run_tm -M -L "$TEST_LABEL" -p "$TEST_IP"
run_tm -M -L "$TEST_LABEL" -m -p "$TEST_IP"
run_tm -M -L "$TEST_LABEL" -m
run_tm -M -L foo

echo ""
echo "======= ADD OP /    MON ======="
run_tm -M -a
run_tm -M -a -m
run_tm -M -a -m -p "$TEST_IP"
run_tm -M -a -p "$TEST_IP"
run_tm -M -a -L "$TEST_LABEL" -p "$TEST_IP"
run_tm -M -a -L "$TEST_LABEL" -m -p "$TEST_IP"
run_tm -M -a -L "$TEST_LABEL" -m
run_tm -M -a -L foo

echo ""
echo "======= ADD OP / NO MON ======="
run -a
run -a -m
run -a -m -p "$TEST_IP"
run -a -p "$TEST_IP"
run -a -L "$TEST_LABEL" -p "$TEST_IP"
run -a -L "$TEST_LABEL" -m -p "$TEST_IP"
run -a -L "$TEST_LABEL" -m
run -a -L foo

