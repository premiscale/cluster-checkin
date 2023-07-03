#! /usr/bin/env bash
# Wrap tests in the cronitor.io API.


_CRONITOR_TELEMETRY_KEY="${CRONITOR_TELEMETRY_KEY:-notset}"
_CLUSTER_ID="${CLUSTER_ID:-rivendell}"


##
# Fail if any nodes are not ready.
test_nodes_not_ready()
{
    kubectl get nodes | grep -qP "(NotReady)"
}


##
# Test if any pods in kube-system are not up and running.
test_kube_system_pods()
{
    kubectl get pods -n kube-system | grep -qP "(Error|ImagePullBackoff|PostStartHookError|PreStopHookError|InvalidImageName)"
}


(curl "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=run" && (
    test_nodes_not_ready && \
    test_kube_system_pods && \
    curl "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=complete"
)) || curl "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=fail"