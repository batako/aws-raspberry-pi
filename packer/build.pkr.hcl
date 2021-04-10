build {
  sources = [
    "source.amazon-ebs.example"
  ]

  provisioner "shell" {
    script = "provision.sh"
  }
}
