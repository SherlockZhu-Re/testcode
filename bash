# From Runlong
#
# Personal cmd path
PATH=$PATH:/root/bin
source /usr/share/bash-completion/bash_completion

# =========================================================
# KUBECTL ALIASES & COMPLETION (FINAL WORKING VERSION)
# =========================================================

# 步骤 1: 加载 kubectl 官方补全脚本
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion bash)
fi

# 步骤 2: 定义最终的智能函数
# (k 函数保持不变)
k() {
  kubectl "$@"
}

# (kg 函数 - 最终修正版)
kg() {
  # 检查第一个参数是否是补全系统的隐藏命令
  if [ "$1" == "__complete" ]; then
    # 如果是，将 'get' 插入到参数列表的第二个位置，
    # 然后再调用 kubectl 的主补全逻辑。
    # "$@" 会被展开为 "__complete" "po" ...
    # 我们把它变成 "__complete" "get" "po" ...
    kubectl "${@:1:1}" "get" "${@:2}"
  else
    # 否则，执行正常的 "get" 操作
    kubectl get "$@"
  fi
}

# (kd 函数 - 最终修正版)
kd() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "describe" "${@:2}"
    else
        kubectl describe "$@"
    fi
}

kde() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "delete" "${@:2}"
    else
        kubectl delete "$@"
    fi
}

ke() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "edit" "${@:2}"
    else
        kubectl edit "$@"
    fi
}

# (ks 函数，用于执行)
ks() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "-n" "kube-system" "${@:2}"
    else
        kubectl -n kube-system "$@"
    fi
}

ksg() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "-n" "kube-system" "get" "${@:2}"
    else
        kubectl -n kube-system get "$@"
    fi
}

ksd() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "-n" "kube-system" "describe" "${@:2}"
    else
        kubectl -n kube-system describe "$@"
    fi
}

ksde() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "-n" "kube-system" "delete" "${@:2}"
    else
        kubectl -n kube-system delete "$@"
    fi
}

kse() {
    if [ "$1" == "__complete" ]; then
        kubectl "${@:1:1}" "-n" "kube-system" "edit" "${@:2}"
    else
        kubectl -n kube-system edit "$@"
    fi
}

# 步骤 3: 为我们所有的函数注册补全
complete -o default -F __start_kubectl k
complete -o default -F __start_kubectl kg
complete -o default -F __start_kubectl kd
complete -o default -F __start_kubectl kde
complete -o default -F __start_kubectl ke

# !! 将 ks 命令的补全请求，指向我们特制的包装函数 !!
complete -o default -F __start_kubectl ks
complete -o default -F __start_kubectl ksg
complete -o default -F __start_kubectl ksd
complete -o default -F __start_kubectl ksde
complete -o default -F __start_kubectl kse



# =========================================================
# Terraform
# =========================================================

alias tf=terraform
