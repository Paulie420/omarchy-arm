#!/bin/bash

set -euo pipefail

source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/base-test.sh"

main="$ROOT/default/sddm/omarchy/Main.qml"

# The greeter is password-only. userModel.lastUser is empty until a first SDDM
# login, so an install that did not come with autologin submitted "" and every
# login failed ("pam_systemd_home: User name not set").
grep -Eq 'property string currentUser: userModel\.lastUser \|\| userModel\.data\(userModel\.index\(0, 0\), Qt\.UserRole \+ 1\)' "$main" ||
  fail "the greeter falls back to the first user when lastUser is empty"
pass "the greeter falls back to the first user when lastUser is empty"

! grep -Eq 'property string currentUser: userModel\.lastUser$' "$main" ||
  fail "currentUser is not lastUser alone"
pass "currentUser is not lastUser alone"
