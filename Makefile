MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
GIT_RSA      :=  $(HOME)/.ssh/ssh_github

push:
	$(MAKEFILE_DIR)/git.sh -i $(GIT_RSA) push -u origin master 

create-tag:
	git tag -a $(tag) -m $(message)

list-remote-tags:
	$(MAKEFILE_DIR)/git.sh -i $(GIT_RSA) ls-remote --tags

push-tag:
	$(MAKEFILE_DIR)/git.sh -i $(GIT_RSA) push -u origin master $(tag)

delete-local-tag:
	git tag -d $(tag)

delete-remote-tag:
	$(MAKEFILE_DIR)/git.sh -i $(GIT_RSA) push origin --delete $(tag)

