# "Efficient Terraform Backend Setup: Harnessing AWS S3 for State Management"

In this project i connect backend as aws " bucket S3" and "DynamoDB"

What is state locking ?

State Locking is terraform inbuild setting for avoid State locking is used to avoid conflicts and ensure the integrity of Terraform state by preventing concurrent modifications from multiple
users or processes.

Note: Not required to set-up "self locking"  when state file save in local, but if we want to save 'terraform state file' in Centralized Storage then need to set-up of self locking.

Remote State File/ Locking :--

Remote state file means we can save our "terraform.tfstate" file in Centralized Storage.
