# Политики безопасности контейнеров

## Запрещенные действия:
1. privileged: true - запрещено
2. runAsUser: 0 - запрещено (требуется runAsNonRoot: true)
3. readOnlyRootFilesystem: false - запрещено (требуется true)
4. hostPath volumes - запрещено

## Разрешенные альтернативы:
- Использовать emptyDir, configMap, secret для хранения данных
- Запускать от non-root пользователя (UID > 1000)
- Использовать безопасные capabilities вместо privileged
- Всегда устанавливать readOnlyRootFilesystem: true

## Процесс аудита:
1. Еженедельный запуск скрипта аудита
2. Мониторинг через Gatekeeper метрики
3. Регулярный review манифестов

Скрипт для проверки существующих подов на нарушения:

``` bash
#!/bin/bash
# audit-existing-pods.sh

NAMESPACE="audit-zone"

echo "Аудит подов в namespace $NAMESPACE"
echo "===================================="

for pod in $(kubectl get pods -n $NAMESPACE -o name); do
    echo "Проверка $pod:"
    
    # Проверка privileged
    if kubectl get $pod -n $NAMESPACE -o yaml | grep -q "privileged: true"; then
        echo "  ❌ Нарушение: privileged container detected"
    fi
    
    # Проверка runAsUser: 0
    if kubectl get $pod -n $NAMESPACE -o yaml | grep -A2 "runAsUser:" | grep -q "0"; then
        echo "  ❌ Нарушение: running as root (UID 0)"
    fi
    
    # Проверка hostPath volumes
    if kubectl get $pod -n $NAMESPACE -o yaml | grep -q "hostPath:"; then
        echo "  ❌ Нарушение: hostPath volume detected"
    fi
    
    echo "---"
done
```