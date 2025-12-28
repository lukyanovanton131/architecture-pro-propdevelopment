

# Проверка, что TemplateConstraints созданы
kubectl get constrainttemplates

# Проверка, что Constraints активны
kubectl get K8sDenyPrivileged,K8sRequireNonRoot,K8sDenyHostPath

# Все манифесты должны быть заблокированы
kubectl apply -f insecure-manifests/01-privileged-pod.yaml
# Ошибка: pods "privileged-pod" is forbidden: violates PodSecurity "restricted:latest"

kubectl apply -f insecure-manifests/02-hostpath-pod.yaml
# Ошибка: pods "hostpath-pod" is forbidden: violates PodSecurity "restricted:latest"

kubectl apply -f insecure-manifests/03-root-user-pod.yaml
# Ошибка: pods "root-user-pod" is forbidden: violates PodSecurity "restricted:latest"
# Должна быть ошибка от Gatekeeper

# Проверка аудита нарушений
kubectl get constraints -o yaml