# controls where InSpec scan reports are sent
# possible values: 'chef-server-automate', 'chef-server-compliance', 'chef-compliance', 'chef-automate', 'json-file'
# notes: 'chef-automate' requires InSpec version 0.27.1 or greater
# deprecated: 'chef-visibility' is replaced with 'chef-automate'
# deprecated: 'chef-server-visibility' is replaced with 'chef-server-automate'
default['audit']['reporter'] = 'chef-server-automate'

# Chef InSpec Compliance profiles to be used for scan of node
# See README.md for details

default['audit']['profiles'] = [
  {
    "name": "DevSec SSH Baseline",
    "compliance": "admin/ssh-baseline"
  }
]
