data "k14s_ytt" "tmc_psp" {
  files = ["${var.ytt_lib_dir}/tmc-privileges"]
}

resource "null_resource" "blocker" {
  provisioner "local-exec" {
    command = "echo 'Unblocked on ${var.blocker}'"
  }
}

resource "k14s_app" "tmc_psp" {
  depends_on = [null_resource.blocker]
  
  name = "tmc-psp"
  namespace = "default"

  yaml = data.k14s_ytt.tmc_psp.result
}