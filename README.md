# Sistema de Predicción de Abandono de Clientes de Telefónica

Este proyecto implementa un sistema de predicción que utiliza un modelo de randomforest para predecir si un cliente de Telefónica abandonará el servicio o no. El sistema ofrece múltiples interfaces de comunicación, incluyendo REST, Kafka y gRPC.

## Datos de entrada para el modelo

| Campo                        | Tipo    | Descripción                           |
|------------------------------|---------|---------------------------------------|
| internet_service             | int     | Tipo de servicio de internet          |
| number_dependents            | int     | Número de dependientes                |
| number_referrals             | int     | Número de referencias                 |
| satisfaction_score           | int     | Puntuación de satisfacción            |
| tenure_in_months             | int     | Tiempo como cliente (en meses)        |
| total_long_distance_charges  | float   | Cargos totales de larga distancia     |
| total_revenue                | float   | Ingresos totales generados            |
| contract                     | string  | Tipo de contrato                      |
| payment_method               | string  | Método de pago                        |


## Características principales

- Interfaces múltiples: REST, Kafka y gRPC.
- Procesamiento concurrente mediante hilos.

## Estructura del proyecto

El proyecto está organizado en los siguientes componentes:

1. **API REST** (`api_rest/app.py`): Implementa un servidor FastAPI para recibir solicitudes HTTP.
2. **API Kafka** (`api_kafka/`):
   - `consumer.py`: Consume mensajes de Kafka y realiza predicciones.
   - `producer.py`: Envía solicitudes de predicción a través de Kafka.
3. **API gRPC** (`api_gRPC/`):
   - `server.py`: Implementa el servidor gRPC.
4. **Modelo de predicción** (`tools/telefonica.py`): Contiene la lógica del modelo de predicción.
5. **Scripts de utilidad**:
   - `lanzar_servidores.sh`: Script para iniciar todos los servidores.
   - `tests.py`: Script para realizar pruebas en las diferentes interfaces.

## Funcionamiento de las interfaces

### REST API

- Endpoint: `GET /predict`
- Acepta parámetros de consulta para los datos del cliente.
- Devuelve la predicción en formato JSON.

### Kafka

- Utiliza dos temas: uno para solicitudes y otro para respuestas.
- El consumidor procesa las solicitudes y envía las predicciones de vuelta.
- El productor envía solicitudes y recibe las respuestas.

### gRPC

- Define un servicio con un método `Predict`.
- El cliente envía los datos del cliente como mensaje protobuf.
- El servidor responde con la predicción.

## Procesamiento concurrente

El sistema utiliza hilos para manejar múltiples solicitudes simultáneamente, especialmente en las implementaciones de Kafka y gRPC.

## Cómo usar

1. **Crear ambiente e instalar las dependencias**:


```bash
    python -m venv env
    source env/bin/activate
    pip install -r requirements.txt
```

2. **Lanzar los servidores**:

```bash
     ./lanzar_servidores.sh
```

Este script inicia los servidores REST, gRPC y el consumidor de Kafka.

1. **Realizar pruebas**:

```bash
    python test.py
```

Este script realiza pruebas en todas las interfaces (REST, Kafka, gRPC).