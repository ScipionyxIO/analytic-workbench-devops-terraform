# Motivation
Update to AWS key pairs to access EC2 resources.

# Procedure
chmod 400 Production.pem
chmod 400 Infrastructure.pem

ssh-keygen -y -f Production.pem
ssh-keygen -y -f Infrastructure.pem