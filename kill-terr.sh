#!/bin/sh

echo -e "\n[ Removendo sua infra... ]\n"
terraform destroy infra/
