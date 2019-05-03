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
    )
}
create_variables