

# Проверка, что TemplateConstraints созданы
kubectl get constrainttemplates

# Проверка, что Constraints активны
kubectl get K8sDenyPrivileged,K8sRequireNonRoot,K8sDenyHostPath

kubectl apply -f secure-manifests/01-secure.yaml
kubectl apply -f secure-manifests/02-secure.yaml
kubectl apply -f secure-manifests/03-secure.yaml

# Проверка аудита нарушений
kubectl get constraints -o yaml