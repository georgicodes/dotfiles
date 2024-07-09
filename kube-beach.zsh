
alias latestpod='function _latestpod() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: latestpod <deployment_name> <cluster_name>"
    return 1
  fi
  local deployment_name="$1"
  local cluster_name="$2"
  kubectl config use-context "$cluster_name"
  if [ $? -ne 0 ]; then
    echo "Failed to switch context to cluster: $cluster_name"
    return 1
  fi
  local pod_name
  pod_name=$(kubectl get pods --selector=app=$deployment_name --sort-by=.metadata.creationTimestamp -o jsonpath="{.items[-1].metadata.name}")
  if [ -z "$pod_name" ]; then
    echo "Failed to get pod for deployment: $deployment_name"
    return 1
  fi
  kubectl logs "$pod_name"
}; _latestpod'

alias execpod='function _execpod() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: execpod <deployment_name> <cluster_name>"
    return 1
  fi
  local deployment_name="$1"
  local cluster_name="$2"
  kubectl config use-context "$cluster_name"
  if [ $? -ne 0 ]; then
    echo "Failed to switch context to cluster: $cluster_name"
    return 1
  fi
  local pod_name
  pod_name=$(kubectl get pods --selector=app=$deployment_name --sort-by=.metadata.creationTimestamp -o jsonpath="{.items[-1].metadata.name}")
  if [ -z "$pod_name" ]; then
    echo "Failed to get pod for deployment: $deployment_name"
    return 1
  fi
  kubectl exec -ti "$pod_name" -- /bin/sh
}; _execpod'


alias wsclogs='latestpod desktop-workspaces-client tools-dev-iad-2'
alias wsclaunch='bedrock launch desktop-workspaces-client dev'
alias wscbuild='bedrock build desktop-workspaces-client'
alias wscpods='kubectl --context tools-dev-iad-2 get pods --selector=desktop-workspaces-client --sort-by=.metadata.creationTimestamp'
alias wscexec='execpod desktop-workspaces-client tools-dev-iad-2'
