#! /usr/bin/env bash
# Wrap tests in the cronitor.io API.


set -o pipefail
shopt -s nullglob


# Service will not start without these environment variables.
_CRONITOR_TELEMETRY_KEY="${CRONITOR_TELEMETRY_KEY:?}"
_CLUSTER_ID="${CLUSTER_ID:?}"


##
# Fail if any nodes are not ready.
test_nodes_not_ready()
{
    kubectl get nodes

    kubectl get nodes | grep -qP "(NotReady)"

    # Invert the last exit code.
    test $? -eq 1
}


##
# Test if any pods in namespaces are not up and running.
test_pods_namespace()
{
    if [ $# -ne 1 ]; then
        printf "Function \"test_pods_namespace\" expected 1 argument: namespace name." >&2
        exit 1
    fi

    local namespace="$1"

    kubectl get pods -n "$namespace"

    kubectl get pods -n "$namespace" | grep -qP "(Error|ImagePullBackoff|PostStartHookError|PreStopHookError|InvalidImageName)"

    # Invert the last exit code.
    test $? -eq 1
}


(curl -s "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=run" && (
    test_nodes_not_ready && \
    test_pods_namespace "kube-system" && \
    curl -s "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=complete"
)) || curl -s "https://cronitor.link/p/$_CRONITOR_TELEMETRY_KEY/$_CLUSTER_ID?state=fail"
