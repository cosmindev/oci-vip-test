# GETTING STARTED
#
# 1. Download and install TerraForm (https://www.terraform.io/downloads.html)
# 2. Download and install the OCI TerraForm provider (https://github.com/oracle/terraform-provider-oci/)
# 3. Make sure that you have an OCI API key setup
#       See https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm for directions on creating an API signing key
#       See https://docs.us-phoenix-1.oraclecloud.com/Content/Identity/Tasks/managingcredentials.htm on how to manage API keys in the OCI UI or API
# 4. Copy your tenancy OCID below (bottom part of OCI screen, after Tenancy OCID: heading)
# 5. Copy your OCI user account OCID (login to OCI > Identity > Users)
# 6. Copy the required API key fingerprint and private key path (below)
# 7. Fill-in the full path to the SSH public and private keys (this can be used when creating new instances)
#       See https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Tasks/creatingkeys.htm for directions on how to create this key pair
#
# HELPFUL URLs
# * https://github.com/oracle/terraform-provider-oci/blob/master/docs/Table%20of%20Contents.md
#

# RUNNING TerraForm
#
# Once you've gone through the steps mentioned above, you need to populate your environment variables, by sourcing this file... steps are below:
# 1. Modify this file (so it reflects your OCIDs, etc.)
# 2. $ terraform init
#       You only have to do this once after installing or upgrading your TerraForm plugins
# 3. $ terraform plan
#       This will show you what TerraForm might do if you applied it
# 4. $ terraform apply

#############################
# TENANCY DETAILS
#############################

# Get this from the bottom of the OCI screen (after logging in, after Tenancy ID: heading)
tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaa3qmjxr43tjexx75r6gwk6vjw22ermohbw2vbxyhczksgjir7xdq"

# Get this from OCI > Identity > Users (for your user account)
user_id = "ocid1.user.oc1..aaaaaaaaoj3k4zp24w2aryx7z46gzhw2yxf2lrvcj3om6cikwb6k4c2p74sq"

# the fingerprint can be gathered from your user account (OCI > Identity > Users > click your username > API Keys fingerprint (select it, copy it and paste it below))
fingerprint = "25:93:69:40:2f:5b:d2:25:0e:eb:f3:41:ea:cb:18:02"

# this is the full path on your local system to the private key used for the API key pair
private_key_path = "/Users/cotudor/.oci/oci_api_key_cotud.pem"

# region (us-phoenix-1, ca-toronto-1, etc)
region = "eu-frankfurt-1"

#############################
# TENANCY DETAILS
#############################

# default compartment 
default_compartment_id = "ocid1.compartment.oc1..aaaaaaaacnmuyhg2mpb3z6v6egermq47nai3jk5qaoieg3ztinqhamalealq"

# iam compartment - if null then default_compartment_id will be used
iam_compartment_id = null

#############################
# naming convension
#############################

# the prefix that will be used for all the names of the OCI artifacts that this automation will provision
names_prefix = "oci-vip-nginx"

# the defined tags to be used for all the artifacts that this automation will provision
defined_tags = {}

# the freeform tags to be used for all the artifacts that this automation will provision
freeform_tags = {}

#############################
# volumes - block storage
#############################

# block storage compartment - if null then default_compartment_id will be used
block_storage_compartment_id = null

# The aditional block volumes backup policy: Bronze, Silver or Gold. Default = Bronze. Null = Bronze
volumes_backup_policy = null

# The aditional block volumes mount point
aditional_block_volume_mount_point = "/u01"

# The aditional block volumes size
aditional_block_volume_size = 55

#############################
# OCI VIP network
#############################

# The specific network compartment id. If this is null then the default, project level compartment_id will be used.
network_compartment_id = null

# the VCN id where the VIP network components will be provisioned
vcn_id = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaac3adhhqaflbvd4jxuvkpwzwxd7r33ndprlxedneoakau6eh4gq2q"

# the route table attached to the VIP subnet. Configuration supports both public internet routes and private routes
oci_vip_route_table = {
  route_rules = [{
    # route to public internet ("0.0.0.0/0") or to private destination
    dst      = "0.0.0.0/0"
    dst_type = "CIDR_BLOCK"
    # next hop can be an Internet Gateway or other Gateway(ex. DRG)
    next_hop_id = "ocid1.internetgateway.oc1.eu-frankfurt-1.aaaaaaaaagq6h5w3su6certxerl34f4xluf67nlxh4phxtev5jahsnaznowa"
  }]
}

# VIP subnet DHCP options
dhcp_options = {
  oci_vip_dhcp_option = {
    server_type        = "VcnLocalPlusInternet"
    search_domain_name = "DomainNameServer"
    forwarder_1_ip     = null
    forwarder_2_ip     = null
    forwarder_3_ip     = null
  }
}

# VIP subnet CIDR
oci_vip_subnet_cidr = "10.0.80.0/24"

# option for having a public and private VIP or just a private VIP
assign_public_ip = true

#############################
# File System Details
#############################

# The specific FSS compartment id. If this is null then the default, project level compartment_id will be used.
fss_compartment_id = null

# The FSS configuration. If null(file_system = null) then no FSS artifacts will not be configured
file_system = {
  # the File Sytem and mount target AD - AD number
  availability_domain = 1
  export_path         = "/u02"
}

# the folder(mount point) where the FSS NFS share will be mounted
fss_mount_point = "/u02"

#############################
# OCI VIP Instances
#############################

# The specific compute compartment id. If this is null then the default, project level compartment_id will be used.
compute_compartment_id = null

# The number of cluster nodes to be provisioned
cluster_size = 2

# Compute instances ssh public key
ssh_public_key_path = "~/.ssh/cos_key.pub"

# Compute instances ssh private key
ssh_private_key_path = "~/.ssh/cos_key.openssh"

# The name of the shape to be used for all the provisioned compute instances. The automation will automatically figure out the OCID for the specific shape name in the target region.
shape = "VM.Standard2.1"

# The name of the image to be used for all the provisioned compute instances. The automation will automatically figure out the OCID for the specific image name in the target region.
image_name = "Oracle-Linux-7.8-2020.06.30-0"


# OCI VIP Config

# Accepted values: ["Apache", "Nginx"] 
install_product = "Nginx"

# Keepalived check script
# Only 2 values are accepted:
# - "'/usr/sbin/pidof httpd'"
# - "'/usr/sbin/pidof nginx'"
keepalived_check = "'/usr/sbin/pidof nginx'"

#############################
# OCI VIP Util Nodes
#############################

# Option to have an util compute node provisioned or not.
provision_util_node = false
