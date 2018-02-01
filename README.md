# IoT-Device-Simulator

Simulator of all the IoT devices manufactured by Sinapse Energía. 
The device and the API that understands are populated though different JSON files. 
The APIs are based on MQTT and follows an OpenAPI Specifications: https://www.asyncapi.com/

# Basic user history

1. User connects
2. Its devices list is empty. Go to Templates in order to create a new device
3. Templates is empty. Import a JSON that model a HW Device (For example IoT HUB). JSON import OK
4. Now, there is one Template named IoT HUB and the user is able to create a Device based on this Template. The user clicks on Create Device
5. During the creation phase, the user needs to verify the pheripheral connections and change them if needed (enabled, idle, error). Set the name of the Device to SCINAP
6. Now, there is one Device, named SCINAP, but still does not understand any API. The user go to Device > Management and import an API named SCINAP API v0.0.1. Import OK
7. Now, SCINAP understands the SCINAP API v0.0.1. Go to Device > MQTT Client and connect to a Broker. Connection OK
8. Now, it is possible to communicate with the SCINAP device from other MQTT Client sending any kind of understood message and receiving responses. 
9. The SCINAP keep connected and listenning unless the user disconnect the device.

# JSON Files

The simulator will manage two kind of JSON files. API-JSON and HW-JSON:

## API-JSON

It describes the MQTT API understood by a Device. It is based in an OpenAPI specification named asyncapi: https://www.asyncapi.com/. The API-JSON doesn't follow the whole specification because we have cases not covered by the specification yet. Anyway, it follow a big part of the specification and will be adaptable in the future. With the current JSON it is possible to understand how works the API and model it in a MQTT Client

## HW-JSON

It describes a generic hardware device (Template) and contains the structure of a Sinapse HW Device, with the interfaces and the pheripherals. It not follows any open specification, instead is a Sinapse Internal format.

# MOCKUP

https://github.com/Sinapse-Energia/IoT-Device-Simulator/blob/master/Doc/IoT%20Device%20Simulator_mockup.pdf

# MVP

The minimum viable product is the implementation of the basic history with the MVP JSONs:

MVP Hardware: https://github.com/Sinapse-Energia/IoT-Device-Simulator/tree/master/HWs/MVP
MVP API: https://github.com/Sinapse-Energia/IoT-Device-Simulator/tree/master/APIs/MVP

