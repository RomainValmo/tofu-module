## How to use this module 

### 1. You must create a private key for ssh.

This key will be use by tofu to connect to node and install K8s

```
ssh-keygen -t rsa -b 4096 -C "name" -f /path/to/yours/keys
```

This command will create two files, your private key and yours public

These files are used :
- for private to dedicate variable
- for public in node block variable


<br>

### 2. You have to get a GCP account 

a) [Create GCP free account](https://cloud.google.com/gcp?utm_source=google&utm_medium=cpc&utm_campaign=emea-fr-all-en-bkws-all-all-trial-b-gcp-1707574&utm_content=text-ad-none-any-DEV_c-CRE_673503512349-ADGP_Hybrid%20%7C%20BKWS%20-%20BRO%20%7C%20Txt%20-%20GCP%20-%20General%20-%20v3-KWID_43700077892352680-kwd-14471151-userloc_1006235&utm_term=KW_gcp-NET_g-PLAC_&&gad_source=1&gclid=Cj0KCQiAvbm7BhC5ARIsAFjwNHtNS45HY31L_8IwyVGn1jTDKshUmuQCrWpFiFME6oOyIl-gzAXnqS4aAs4rEALw_wcB&gclsrc=aw.ds&hl=en)

b) Create a GCP project 

c) Create a Service Account, bind it owner role and generate a key in Json format 


### 3. Use this module

a) Copy these tree example files to your local folder 

b) adapt your terraform.tfvars with your current values
 - set your SSH private key (private_key_ssh)
 - set your SSH public key
 (ssh-file)
 - set your SSH Host
 (ssh-host)
 - set your GCP project
 (gcp_project_id)
 - set your GCP SA Json file
 (gcp_credentials_file)

c) Once all are set, use these commands:

- tofu init
- tofu plan
- tofu apply
