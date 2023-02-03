.PHONY: run
run:
	ansible-playbook -i inventory.ini run.yaml
destroy:
	ansible-playbook -i inventory.ini destroy.yaml
ping:
	ansible all -m ping -i inventory.ini