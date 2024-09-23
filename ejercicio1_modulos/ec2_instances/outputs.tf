output "instance_ids" {
  description = "Lista de IDs de las instancias EC2 creadas"
  value       = aws_instance.example[*].id
}
