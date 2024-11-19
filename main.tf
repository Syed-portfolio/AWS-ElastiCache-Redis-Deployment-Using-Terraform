provider "aws" {
  region = "us-east-2" // Ensure the region matches your subnet's AZ
}

resource "aws_elasticache_subnet_group" "example" {
  name       = "new-redis-subnet-group" // Use a new name
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
