# "Efficient Terraform Backend Setup: Harnessing AWS S3 for State Management"

![terraform-backend](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/ed852141-0194-493c-9444-76acda29ffd7)


In this project i connect backend as aws " bucket S3" and "DynamoDB"

🌟What is state locking ?

State Locking is terraform inbuild setting for avoid State locking is used to avoid conflicts and ensure the integrity of Terraform state by preventing concurrent modifications from multiple
users or processes.

Note: Not required to set-up "self locking"  when state file save in local, but if we want to save 'terraform state file' in Centralized Storage then need to set-up of self locking.

🌟Remote State File/ Locking :--

Remote state file means we can save our "terraform.tfstate" file in Centralized Storage.

Using centralized storage means keeping all Terraform configuration information in one place that everyone on the team can access. It helps everyone work together smoothly and ensures that 
everyone has the same up-to-date information about the infrastructure. It also adds security features like access control and makes it easier to back up and manage large amounts of data.


⚙️Following steps need to do on AWS console :

⚡Step-1:(Create an S3 Bucket)

Go to aws console search "S3" then click create S3 bucket,in my case name of bucket is "tf-ps", select region same as terraform plugin.

⚡Step-2:(Create a Folder in the Bucket)

 After S3 Bucket is created then need to create folder to manage things.

 aws console -->> in S3 , Click on S3 bucket("tf-ps") click on create folder and give folder name in my case "webdev" is key name .

 Note:-

 When we use aws S3 bucket as Backend for terraform state file then terraform state locking not work, For enable 'state-locking' in S3 bucket then we have use "DynamoDB" with "S3". 
 External locking mechanism we used.

⚡Step-3: (DynamoDB table)

on aws console-->> search "dynamoDB" then click on 'Dashboard' , create table in my case name is "table-locking-statefile". 
Then partition key = LockID .



❄️ Now on Terraform 💻❄️

✧ Step-1:--

       #notepad provider.tf

![provider tf](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/eaca1b18-16da-40e0-b2ee-b4212799edf3)

bucket: Specifies the name of the S3 bucket where Terraform state will be stored.

key: Specifies the path within the bucket where the state file will be stored.

region: Specifies the AWS region where the S3 bucket is located.

dynamodb_table: Specifies the name of the DynamoDB table used for state locking.


✧ Step-2:--

    #notepad main.tf

![main tf-1](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/69380606-fb4d-4424-b7fc-0c08510a2da9)
![main tf-2](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/f0decdb5-5f3b-4b15-a25f-12469d8e14b2)

This Terraform configuration creates an AWS EC2 instance, referencing the most recent Amazon Machine Image (AMI) meeting specific criteria, and sets up a security
group allowing inbound traffic on specified ports.


# Now Check State Locking working for remote Backend state file 
For this i use Two terminal of same terraform plugin, and form that two terminal(console) i run "terraform apply command"

Note : 

For plugin 1st need to run follow command:

    # terraform init
    
And also use to reconfigure precreated 

    # terraform.exe init -reconfigure

Now terraform apply command run from two terminal at same but only one worl:

    #terraform apply

In Below screenshot, When 1st terminal(user1) run apply command at same time 2nd terminal(user2) run same apply command, Here only 1st user command work and 2nd user command not work 
it goes under 'State Lock'.
![state-lock](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/6f63d12b-d757-49b2-b05d-f16489f5cb18)

✧ After user1 Infrastucture done we again run same apply , the user2 terminal is state locked is now open see in below Screenshot: 

![state-lock-2](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/179e7c65-af8e-4f2d-82cb-0783c5c54ab4)


✧ State File (terraform.tfstate) is not save locally on Both user/terminal :

![tf-statelocking-file](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/71c3b6ca-b0ff-4aeb-82e0-d6713ca57cbc)


Note:

When user2 goes under state locking then ".terraform.lock.hcl" file automatically install on locally .

   #ls -a
   
![ps](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/3ffb5194-add2-4018-b102-9c34d9c279be)


❄️ On aws Console infrastucture done:


✧ EC2 instance is lanuched :


![Screenshot 2024-04-08 150114](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/c47f81ae-bc1a-44a2-88bf-46e70cc9f749)



✧ AWS S3 Bucket:(my.state file is created)


![Screenshot 2024-04-08 150307](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/4e0dcf2b-2743-480d-8333-295e9823bc01)
![Screenshot 2024-04-08 150421](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/ed59e36f-4861-4843-a17b-d28586f1e09e)
![Screenshot 2024-04-08 150431](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/996f029e-f86a-4993-812b-01a070fbdc16)

✧ AWS DynamoDB:


![Screenshot 2024-04-08 150239](https://github.com/Pratikshinde55/Terraform-Remote-Backend-state_locking/assets/145910708/64e1c8be-2c6e-4205-bde0-4fade7a92375)





















