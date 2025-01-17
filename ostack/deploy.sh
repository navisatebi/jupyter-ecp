#!/usr/bin/env bash
# Set color variable
CYAN='\033[1;36m'
NC='\033[0m' # No Color

set -e
# Provisions a virtual machine instance

# Local variables
export APP="${PORTAL_APP_REPO_FOLDER}"
echo "export APP=${APP}"

export TF_VAR_deployment_path="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}"
echo "export TF_VAR_deployment_path=${TF_VAR_deployment_path}"

export DPL="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}/"
echo "export DPL=${DPL}"

export PRIV_KEY_PATH="${DPL}${PORTAL_DEPLOYMENT_REFERENCE}"
echo "export PRIV_KEY_PATH=${PRIV_KEY_PATH}"

# Export input variables in the bash environment
export TF_VAR_name="$(awk -v var="${PORTAL_DEPLOYMENT_REFERENCE}" 'BEGIN {print tolower(var)}')"
echo "export TF_VAR_name=${TF_VAR_name}"

export KEY_PATH="${DPL}${PORTAL_DEPLOYMENT_REFERENCE}.pub"
echo "export KEY_PATH=${KEY_PATH}"

export TF_VAR_key_path="${KEY_PATH}"
echo "export TF_VAR_key_path=${TF_VAR_key_path}"

export TF_STATE=${DPL}'terraform.tfstate'
echo "export TF_STATE=${TF_STATE}"

# Launch provisioning of the VM
echo -e "\n\t${CYAN}Terraform apply${NC}\n"
terraform apply --state=${DPL}'terraform.tfstate' ${APP}'/ostack/terraform'

# Extract the external IP of the instance
external_ip=$(terraform output -state=${DPL}'terraform.tfstate' external_ip)
export external_ip=${external_ip}
echo "export external_ip=${external_ip}"



#    OS_NETWORK  OS_PROJECT_ID OS_REGION_ONE  OS_USER_DOMAIN_NAME

# Set default value for Ansible variables if they are either empty or undefined

cd ostack/ansible 

# Export openstack variables
export auth_url="${OS_AUTH_URL}"
echo "export OS_AUTH_URL=${OS_AUTH_URL}"

export os_username="${OS_USERNAME}"
echo "export OS_USERNAME=${OS_USERNAME}"

export os_password="${OS_PASSWORD}"
echo "export OS_PASSWORD=${OS_PASSWORD}"

export os_project_name="${OS_PROJECT_NAME}"
echo "export OS_PROJECT_NAME=${OS_PROJECT_NAME}"

export os_interface="${OS_INTERFACE}"
echo "export OS_INTERFACE=${OS_INTERFACE}"

export os_identity_api_version="${OS_IDENTITY_API_VERSION}"
echo "export OS_IDENTITY_API_VERSION=${OS_IDENTITY_API_VERSION}"

echo "Installing ssh-reconnect, evandam.conda"
ansible-galaxy install -r requirements.yml 

export ANSIBLE_REMOTE_USER="${TF_VAR_remote_user:-ubuntu}"
echo "export ANSIBLE_REMOTE_USER=${ANSIBLE_REMOTE_USER}"

export ANSIBLE_HOST_KEY_CHECKING=False

export TF_VAR_name="${TF_VAR_name}"
echo "export TF_VAR_name=${TF_VAR_name}"

# Launch Ansible playbook
echo -e "\n\t${CYAN}Launch Ansible playbook${NC}\n"
ansible-playbook -b playbook.yml -e 'ansible_python_interpreter=/usr/bin/python3' -e 'host_key_checking=False' -v
