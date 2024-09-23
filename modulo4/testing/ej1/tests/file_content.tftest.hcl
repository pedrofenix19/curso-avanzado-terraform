provider "local" {}


run "check_file_content" {
    command = apply
    assert {
        condition = filesha256(local_file.example.filename) == sha256("Hello, Terraform!")
        error_message = "El contenido del archivo es incorrecto."
    }
}
