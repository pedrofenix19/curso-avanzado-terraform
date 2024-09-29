## Módulo 1

Ejemplo de módulo que crea instancias de EC2 basándose en una lista de nombres de instancias

Para ejecutar el ejemplo:
```
terraform init
terraform plan 
terraform apply
```

El módulo raíz asigna por defecto el valor [ "instancia1", "instancia2" ] a la variable instance_names. Este valor puede cambiarse creando un archivo .tfvars y pasándoselo a los comandos terraform plan y terraform apply mediante el flag -var-file.

Ejemplo.

```
#Archivo terraform.tfvars
instance_names = ["nombre_instacnia1", "nombre_instancia_2"]
```

y luego

```
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```