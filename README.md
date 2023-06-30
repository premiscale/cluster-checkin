# cluster-checkin

Cronjob that checks in with [cronitor.io](https://cronitor.io/) and alerts if the following items in a cluster are off (or if it doesn't check in at all) -

- All nodes are in a `Ready` state. E.g.,

   ```yaml
   $ k get node
   NAME                 STATUS   ROLES               AGE    VERSION
   192.168.1.214        Ready    controlplane,etcd   73d    v1.24.9
   192.168.1.227        Ready    controlplane,etcd   73d    v1.24.9
   rivendell-master-1   Ready    controlplane,etcd   135d   v1.24.9
   rivendell-master-2   Ready    controlplane,etcd   135d   v1.24.9
   rivendell-master-3   Ready    controlplane,etcd   135d   v1.24.9
   rivendell-node-1     Ready    worker              135d   v1.24.9
   rivendell-node-10    Ready    worker              135d   v1.24.9
   rivendell-node-11    Ready    worker              135d   v1.24.9
   rivendell-node-12    Ready    worker              135d   v1.24.9
   rivendell-node-2     Ready    worker              135d   v1.24.9
   rivendell-node-3     Ready    worker              135d   v1.24.9
   rivendell-node-4     Ready    worker              135d   v1.24.9
   rivendell-node-5     Ready    worker              135d   v1.24.9
   rivendell-node-6     Ready    worker              135d   v1.24.9
   rivendell-node-7     Ready    worker              135d   v1.24.9
   rivendell-node-8     Ready    worker              135d   v1.24.9
   rivendell-node-9     Ready    worker              135d   v1.24.9
   ```