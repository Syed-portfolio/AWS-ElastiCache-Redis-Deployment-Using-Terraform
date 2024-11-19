### Project: ElastiCache Redis Deployment Using Terraform

#### Objective
Set up and maintain an ElastiCache Redis instance on Amazon Linux using Terraform for infrastructure as code (IaC) automation.

### Detailed Steps

#### Step 1: Install Terraform
**Description:** Installed Terraform on an Amazon Linux EC2 instance to manage and automate AWS infrastructure.

**Commands:**
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

#### Step 2: Create Terraform Configuration Files
**Description:** Created a Terraform configuration file to define the AWS provider, ElastiCache subnet group, and Redis cluster. Ensured the configurations matched the actual AWS environment.

**File: main.tf**
```hcl
provider "aws" {
  region = "us-east-2" // Ensure the region matches your subnet's AZ
}

resource "aws_elasticache_subnet_group" "example" {
  name       = "redis-subnet-group"
  subnet_ids = ["subnet-0b313bf9dfbc70934"] // Your actual subnet ID
}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = "syed-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro" // Adjust as needed
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  subnet_group_name    = aws_elasticache_subnet_group.example.name
  security_group_ids   = ["sg-0b8875bcfc87fc22b"] // Your security group ID
  port                 = 6379
  engine_version       = "6.x"

  tags = {
    Name = "SyedRedisCluster"
  }
}
```

#### Step 3: Initialize and Apply Terraform Configuration
**Description:** Initialized the Terraform working directory and applied the configuration to provision the ElastiCache Redis instance on AWS.

**Commands:**
- **Initialize Terraform**
  ```bash
  terraform init
  ```

- **Apply the Terraform Configuration**
  ```bash
  terraform apply
  ```
  - Confirmed by typing `yes` to apply the configuration.

#### Step 4: Verify the Redis Cluster
**Description:** Verified the successful creation and deployment of the ElastiCache Redis cluster.

![image](https://github.com/user-attachments/assets/796ed8f7-2353-45b6-aaa9-db1604c53eac)

**Verification Steps:**
- Checked the AWS Management Console under the ElastiCache section to ensure the Redis cluster was created successfully.

#### Step 5: Connect to the Redis Cluster from Amazon Linux
**Description:** Connected to the Redis cluster using the Redis CLI from the EC2 instance to ensure connectivity and functionality.

**Steps:**
- **Install Redis CLI**
  ```bash
  sudo yum install redis
  ```

- **Connect to Redis**
  ```bash
  redis-cli -h <redis-endpoint> -p 6379 -a <password>
  ```

### Conclusion
Successfully set up and maintained an ElastiCache Redis instance on Amazon Linux using Terraform. This project showcased the use of infrastructure as code (IaC) to automate and manage AWS resources, ensuring reproducibility and scalability.


