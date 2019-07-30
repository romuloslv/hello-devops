#!/bin/sh

echo -e "\n[ Inicialização dos plugins... ]"
terraform init infra/
echo -e "\n[ Revisão de cenário... ]\n"
terraform plan infra/
echo -e "\n[ Construindo sua infra... ]\n"
terraform apply infra/
echo -e "\n[ Acesse a aplicação... ]\n"
echo "$(terraform output ip):8000"
echo -e "\n[ Acesse o RABBITMQ... ]\n"
echo "$(terraform output ip):15672"
