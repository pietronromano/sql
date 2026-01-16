
# Ejercicio: Diseñar un sistema de información para un banco:

## Clientes: 
id_cliente
nif
…

## Cuentas: un Cliente puede tener 1 o varias Cuentas
id_cuenta
id_cliente
IBAN
tipo_cuenta (corriente, ahorro…)
…

## Movimientos: un Movimiento se realiza para una Cuenta
id_movimiento
montante
fecha
id_cuenta

## Transferencia: una Transferencia se realiza entre dos Cuentas
id_transferencia
id_cuenta_origen
id_cuentra_destino
cantidad
fecha

## Prestamos: un Cliente puede tener 0 o varios Prestamos
id_prestamo
id_cliente
cantidad
fecha
