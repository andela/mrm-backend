data "template_file" "ingress" {
  template = "${file("${var.ingress_template_file}")}"

  vars {
    namespace                 = "${var.namespace}"
    regional_static_ip        = "${var.regional_static_ip}"
    frontend_domain_name      = "${var.frontend_domain_name}"
    backend_domain_name       = "${var.backend_domain_name}"
    microservice_domain_name  = "${var.microservice_domain_name}"
  }
}

resource "null_resource" "apply" {
  triggers {
    ingress_file           = "${md5(data.template_file.ingress.rendered)}"
  }

  depends_on = [
    "kubernetes_secret.tls_secrets",
    "kubernetes_service.backend",
    "kubernetes_service.frontend",
  ]

  provisioner "local-exec" {
    command = <<EOF
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
kubectl apply -f k8s/Ingress/mandatory.yml
echo '${data.template_file.ingress.rendered}' | kubectl apply -f -
EOF
  }

}
