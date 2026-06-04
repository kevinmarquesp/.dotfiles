MAKEFILE := $(HOME)/.local/lib/homectl/Makefile
TIMESTAMP := $(shell date +%y%m%d%H%M)

TARGET := $(PWD)/backup.$(TIMESTAMP)
PRIVATE_TARGET := $(PWD)/private-backup.$(TIMESTAMP)

CLEAN := \
  $(HOME)/.cache \
	$(HOME)/.local/cache \
	$(ADD_CLEAN)  # user defined env

BACKUP := \
  $(HOME)/.bashrc \
  $(HOME)/.config/git \
  $(HOME)/.config/vim \
	$(ADD_BACKUP)  # user defined env

PRIVATE_BACKUP := \
	$(HOME)/.ssh \
	$(ADD_PRIVATE_BACKUP)  # user defined env

default:
	@cat $(MAKEFILE) | less

clean:
	@rm -vrf $(CLEAN)

backup: backup/private
	@mkdir -vp '$(TARGET).temp'
	@echo '$(BACKUP)' | tr ' ' '\n' | \
		xargs -I '{}' -- cp -vr '{}' '$(TARGET).temp'
	@tar -czf '$(TARGET).tar.gz' '$(TARGET).temp' && \
		rm -vrf '$(TARGET).temp'

backup/private:
	@mkdir -vp '$(PRIVATE_TARGET).temp'
	@echo '$(BACKUP)' | tr ' ' '\n' | \
		xargs -I '{}' -- cp -vr '{}' '$(PRIVATE_TARGET).temp'
	@tar -czf '$(PRIVATE_TARGET).tar.gz' '$(PRIVATE_TARGET).temp' && \
		rm -vrf '$(PRIVATE_TARGET).temp'
