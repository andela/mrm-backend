# create array of variables in template files
create_variables (){
    VARIABLES+=(
    project
    region
    zone 
    environment
    prefix
    credentials
    bucket
    name
    source
    credentials_file
    namespace
    backend_name
    backend_image
    backend_container_port
    frontend_name
    frontend_image
    frontend_container_port
    ingress_template_file
    regional_static_ip
    frontend_domain_name
    backend_domain_name
    tls_certificate_file
    tls_key_file
    microservice_name
    microservice_image
    microservice_container_port
    microservice_domain_name
    microservice_namespace
    service_image
    master_liveness_probe
    storage_name
    storage_claim
    service_name
    master_port
    storage_provisioner
    config_name
    ingress_name
    mount_path
    config_template_file
    ingress_file
    host_name
    username
    password
    ingress_controller_file
    )
}
create_variables
