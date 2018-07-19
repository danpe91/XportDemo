name 'opsworks-audit'
maintainer 'AWS OpsWorks Demos'
maintainer_email 'opsworks-cm-feedback@amazon.com'
description 'Installs/Configures opsworks-audit'
long_description 'Installs/Configures opsworks-audit'
version '1.0.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to the Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/opsworks-audit/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# the Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/opsworks-audit'


depends 'audit'
