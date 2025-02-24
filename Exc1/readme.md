# Масштабирование и Kubernetes
**Горизонтальное масштабирование** — будет предпочтительным для обеспечения высокой доступности и отказоустойчивости. Вертикальное масштабирование ограничено ресурсами, и его недостаточно для обработки увеличивающихся нагрузок, особенно при росте RPS.

Будет несколько кластеров Kubernetes в разных зонах доступности. Это обеспечит отказоустойчивость при сбоях в одной из зон.

### Почему несколько кластеров предпочтительнее одного широкого:
- **Изоляция отказов**: Использование нескольких кластеров в разных зонах доступности снижает риск того, что сбой в одном кластере повлияет на все сервисы. В случае сбоя одной зоны, другие кластеры продолжают работать, что повышает отказоустойчивость.

- **Меньшая латентность**: Размещение кластеров ближе к пользователям в разных регионах позволяет снизить задержку запросов и ускорить загрузку страниц, что улучшает пользовательский опыт.

- **Управляемость**: Несколько кластеров позволяют лучше управлять нагрузкой, так как можно масштабировать отдельные зоны или компоненты системы без влияния на весь кластер. Это упрощает мониторинг и управление.

- **Обеспечение доступности**: В случае плановых обновлений или технических работ в одной зоне, другие кластеры смогут продолжать обслуживание запросов. Это помогает достичь требуемой доступности на уровне 99.9%.

- **Разделение ресурсов**: Несколько кластеров позволяют более эффективно распределять ресурсы между зонами, избегая проблем, связанных с перегрузкой отдельных узлов или сервисов, что особенно важно при резких пиках нагрузки.

# Балансировка нагрузки

1. **Global Server Load Balancer (GSLB)**:
   - **Распределение трафика** между зонами доступности (Москва и Новосибирск).
   - **Active Failover**: при сбое одной зоны трафик перенаправляется в другую.
   - **Health Checks**: GSLB проверяет доступность кластеров и перенаправляет трафик только на здоровые зоны.

2. **Балансировка внутри зон**:
   - **Kubernetes**: распределяет запросы между подами в каждом кластере.


# Выбор failover стратегии

## Основные требования:

1. **RTO (Recovery Time Objective)** — 45 минут
    - Время восстановления после сбоя не должно превышать 45 минут.

2. **RPO (Recovery Point Objective)** — 15 минут
    - Потеря данных не должна превышать 15 минут в случае сбоя.

3. **Доступность приложения** — 99.9%
    - Приложение должно быть доступно с уровнем доступности 99,9%.

4. **Одинаковое время загрузки страниц для пользователей из разных регионов**
    - Время загрузки страниц не должно зависеть от географического местоположения пользователей.

## Выбор стратегии

Исходя из предоставленных требований единственная подходящая стратегия Active-Active с георезервированием

# Конфигурация базы данных
1. **Репликация данных:**
   - **Синхронная репликация** для основного и резервного узлов (в пределах региона).
   - **Асинхронная репликация** в другой регион для большей устойчивости.

2. **Резервное копирование:**
   - **Инкрементальные бэкапы** каждые 15 минут для соответствия RPO.
   - **Полные бэкапы** еженедельно.

3. **Фреймворк для кластера БД:**
   - **PostgreSQL с Patroni** для управления кластером и фейловера.

4. **Шардирование БД:**
   - Шардирование **не требуется**, так как текущие требования по нагрузке (при суммарном весе 50gb) могут быть покрыты репликацией.



