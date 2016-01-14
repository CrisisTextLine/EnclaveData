### Purpose

This repo is to track all issues, host the wiki of, and contain the full code and architecture of the code-named "Level 3" project for Crisis Text Line data partner access. The goal of this project is to setup a straighforward and secure environment within which trusted partners can gain access limited subsets of anonymized data while making the barrier of entry for exporting data very high. In essence, the virtual sign on the wall says "Members Only, No Pictures Allowed." Each partner will only be able to access the resources allocated to them. Technical details and some project plans can be found below.

### Technical Notes
The current setup is going be based on a self-hosted environment using KVM virtualization. Ideally, almost all steps here should be replicatable in a public or private cloud environment. Indeed, some of this might be hosted in such a cloud at some point. However, we're currently focusing solely on self-hosted environments. 

There are a few technical assumptions currently within this initial version of the environment:

1. All servers, outside of the firewall will be based on CentOS 7.
2. Ansible is the preferred automation and config management tool.
3. Open source and free software is used whenever possible.
4. KVM virtualization is being used for production access. VirtualBox will be used for the majority of local development.



