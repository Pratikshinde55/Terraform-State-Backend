# "Efficient Terraform Backend Setup: Harnessing AWS S3 for State Management"

In this project i connect backend as aws " bucket S3" and "DynamoDB"

🌟What is state locking ?

State Locking is terraform inbuild setting for avoid State locking is used to avoid conflicts and ensure the integrity of Terraform state by preventing concurrent modifications from multiple
users or processes.

Note: Not required to set-up "self locking"  when state file save in local, but if we want to save 'terraform state file' in Centralized Storage then need to set-up of self locking.

🌟Remote State File/ Locking :--

Remote state file means we can save our "terraform.tfstate" file in Centralized Storage.

Using centralized storage means keeping all Terraform configuration information in one place that everyone on the team can access. It helps everyone work together smoothly and ensures that 
everyone has the same up-to-date information about the infrastructure. It also adds security features like access control and makes it easier to back up and manage large amounts of data.


Following steps need to do on AWS console :

Step-1: 

Go to aws console search "S3" then click create S3 bucket,in my case name of bucket is "tf-ps", select region same as terraform plugin.

Step-2:

After S3 Bucket is created then need to create folder to manage things.

aws console -->> in S3 , Click on S3 bucket("tf-ps") click on create folder and give folder name in my case "webdev" is key name .

Note:-

When we use aws S3 bucket as Backend for terraform state file then terraform state locking not work, For enable 'state-locking' in S3 bucket then we have use "DynamoDB" with "S3"
