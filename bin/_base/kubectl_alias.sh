type complete > /dev/null 2>&1
[ $? -eq 0 ] && complete -o default -F __start_kubectl k

alias k='kubectl'

alias ktn='kubectl top node'

alias ktp='kubectl top pod'
alias ktpa='kubectl top pod -A'
alias ktpks='kubectl top pod -n kube-system'
alias ktpu='kubectl top pod -n uds'
# alias ktpuc='kubectl top pod -n uds-ci'
# alias ktpup='kubectl top pod -n uds-prod'
# alias ktput='kubectl top pod -n uds-test'

alias kgns='kubectl get ns'

alias kgn='kubectl get node'
alias kgnw='kubectl get node -o wide'

alias kgpv='kubectl get pv'
alias kgpvw='kubectl get pv -o wide'

alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc -A'
alias kgpvcw='kubectl get pvc -o wide'
alias kgpvcwa='kubectl get pvc -o wide -A'

alias kgds='kubectl get daemonset'
alias kgdsa='kubectl get daemonset -A'
alias kgdsw='kubectl get daemonset -o wide'
alias kgdswa='kubectl get daemonset -o wide -A'

alias kgp='kubectl get pod'
alias kgpa='kubectl get pod -A'
alias kgpks='kubectl get pod -n kube-system'
alias kgpu='kubectl get pod -n uds'
# alias kgpuc='kubectl get pod -n uds-ci'
# alias kgpup='kubectl get pod -n uds-prod'
# alias kgput='kubectl get pod -n uds-test'

alias kgpw='kubectl get pod -o wide'
alias kgpwa='kubectl get pod -o wide -A'
alias kgpwks='kubectl get pod -o wide -n kube-system'
alias kgpwu='kubectl get pod -o wide -n uds'
# alias kgpwuc='kubectl get pod -o wide -n uds-ci'
# alias kgpwup='kubectl get pod -o wide -n uds-prod'
# alias kgpwut='kubectl get pod -o wide -n uds-test'

alias kge='kubectl get endpoints'
alias kgea='kubectl get endpoints -A'
alias kgeks='kubectl get endpoints -n kube-system'
alias kgeu='kubectl get endpoints -n uds'
# alias kgeuc='kubectl get endpoints -n uds-ci'
# alias kgeup='kubectl get endpoints -n uds-prod'
# alias kgeut='kubectl get endpoints -n uds-test'

alias kgs='kubectl get svc'
alias kgsa='kubectl get svc -A'
alias kgsks='kubectl get svc -n kube-system'
alias kgsu='kubectl get svc -n uds'
# alias kgsuc='kubectl get svc -n uds-ci'
# alias kgsup='kubectl get svc -n uds-prod'
# alias kgsut='kubectl get svc -n uds-test'

alias kgsw='kubectl get svc -o wide'
alias kgswa='kubectl get svc -o wide -A'
alias kgswks='kubectl get svc -o wide -n kube-system'
alias kgswu='kubectl get svc -o wide -n uds'
# alias kgswuc='kubectl get svc -o wide -n uds-ci'
# alias kgswup='kubectl get svc -o wide -n uds-prod'
# alias kgswut='kubectl get svc -o wide -n uds-test'

alias kgd='kubectl get deploy'
alias kgda='kubectl get deploy -A'
alias kgdks='kubectl get deploy -n kube-system'
alias kgdu='kubectl get deploy -n uds'
# alias kgduc='kubectl get deploy -n uds-ci'
# alias kgdup='kubectl get deploy -n uds-prod'
# alias kgdut='kubectl get deploy -n uds-test'

alias kgdw='kubectl get deploy -o wide'
alias kgdwa='kubectl get deploy -o wide -A'
alias kgdwks='kubectl get deploy -o wide -n kube-system'
alias kgdwu='kubectl get deploy -o wide -n uds'
# alias kgdwuc='kubectl get deploy -o wide -n uds-ci'
# alias kgdwup='kubectl get deploy -o wide -n uds-prod'
# alias kgdwut='kubectl get deploy -o wide -n uds-test'
