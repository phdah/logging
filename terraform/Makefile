install:
	# Terraform run
	terraform init
	terraform apply -auto-approve
	# kubectl apply -f https://k8s.io/examples/application/cassandra/cassandra-service.yaml
	kubectl apply -f https://k8s.io/examples/application/cassandra/cassandra-statefulset.yaml

start:

stop:

clean:
	terraform destroy -auto-approve # Destroy Terraform
	rm -rf terraform.* .terraform* # Remove all Terraform created files
	kind delete cluster --name log # Remove the k8s cluster created
	rm log-config # Remove the config file that "kind" creates
