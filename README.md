# cluster-checkin

Cronjob that checks in with [cronitor.io](https://cronitor.io/) and alerts if the following items in a cluster are off (or if it doesn't check in at all) -

- All nodes are in a `Ready` state.