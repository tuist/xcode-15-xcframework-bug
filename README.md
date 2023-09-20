# Xcode 15 XCFramework Bug

We noticed with Xcode 15 a functionality of Tuist that relies on building XCFrameworks is broken. This repository reproduces the issue.

## Steps to reproduce

1. Clone the repository: `git@github.com:tuist/xcode-15-xcframework-bug.git`
2. Run `build.sh`
3. Fails 💥

Make sure you run the steps with Xcode 15

## Observations

The issue seems to be related with some internal logic of XCode that doesn't handle symlinked paths like `/var/folders` which is symlinked to `/private/var/folders`. The issue doesn't happen when the project is built with Xcode 14.