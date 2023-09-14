# Define the provider and region
provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

# Define the Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "my_app" {
  name        = "MyElasticBeanstalkApp"  # Replace with your app name
  description = "My Elastic Beanstalk Application"
}

# Define the Elastic Beanstalk environment
resource "aws_elastic_beanstalk_environment" "my_env" {
  name                = "MyElasticBeanstalkEnv"  # Replace with your environment name
  application         = aws_elastic_beanstalk_application.my_app.name
  solution_stack_name = "64bit Amazon Linux 2 v4.5.0 running Node.js"  # Replace with your desired platform

  # Configure environment variables if needed
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "MY_ENV_VAR"
    value     = "my-value"
  }

  # Optionally, specify key pairs for EC2 instances (if applicable)
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "my-key-pair"
  }

  # Optionally, configure autoscaling settings
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "4"
  }

  # Configure the instance type and EC2 key pair (if needed)
  option_settings {
    namespace = "aws:ec2:instances"
    name      = "InstanceType"
    value     = "t2.micro"  # Replace with your desired instance type
  }

  # Optionally, specify an EC2 key pair name
  option_settings {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "my-key-pair"  # Replace with your key pair name
  }

  # Attach an Elastic Load Balancer (ELB) if needed
  option_settings {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
}

# Output the URL of the Elastic Beanstalk environment
output "eb_environment_url" {
  value = aws_elastic_beanstalk_environment.my_env.endpoint
}
