# Motivation

https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc


Creates a server to deploy thingys.

# Usage


# TODO
- external disk
- external configuration


#

terraform init
terraform init
terraform apply

10.0.0.0/16

-> divide by 4 (  Infrastructure, Production, Uat/Demo, Development  )

10.0.0.0/16
	10.0.0.0/18				-> Infrastructure
		10.0.0.0/19			-> Infrastructure - Private
			10.0.0.0/21		-> Infrastructure - Private- Az A
			10.0.8.0/21		-> Infrastructure - Private- Az B
			10.0.16.0/21		-> Infrastructure - Private- Az C
			10.0.24.0/21		-> Infrastructure - Private- Az SPARE	
		10.0.32.0/19			-> Infrastructure - Public
			10.0.32.0/21		-> Infrastructure - Public- Az A
			10.0.40.0/21		-> Infrastructure - Public- Az B
			10.0.48.0/21		-> Infrastructure - Public- Az C
			10.0.56.0/21		-> Infrastructure - Public- Az SPARE
		
    10.0.64.0/18 	-> Production
    		10.0.64.0/19			-> Production - Private
			10.0.64.0/21		-> Production - Private- Az A
			10.0.72.0/21		-> Production - Private- Az B
			10.0.80.0/21		-> Production - Private- Az C
			10.0.88.0/21		-> Production - Private- Az SPARE	
		10.0.96.0/19			-> Production - Public
			10.0.96.0/21		-> Production - Public- Az A
			10.0.104.0/21	-> Production - Public- Az B
			10.0.112.0/21	-> Production - Public- Az C
			10.0.120.0/21	-> Production - Public- Az SPARE
    
    10.0.128.0/18 	-> Uat/Demo
    
    10.0.192.0/18 	-> Development
    		10.0.192.0/19		-> Production - Private
			10.0.192.0/21	-> Production - Private- Az A
			10.0.200.0/21	-> Production - Private- Az B
			10.0.208.0/21	-> Production - Private- Az C
			10.0.216.0/21	-> Production - Private- Az SPARE	
		10.0.224.0/19		-> Production - Public
			10.0.232.0/21	-> Production - Public- Az A
			10.0.240.0/21	-> Production - Public- Az B
			10.0.248.0/21	-> Production - Public- Az C
			10.0.256.0/21	-> Production - Public- Az SPARE