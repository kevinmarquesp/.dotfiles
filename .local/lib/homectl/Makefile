MAKEFILE := $(HOME)/.local/lib/homectl/Makefile
TIMESTAMP := $(shell date +%y%m%d%H%M)

BACKUP_TARGET := $(PWD)/backup.$(TIMESTAMP)
PRIVATE_BACKUP_TARGET := $(PWD)/private-backup.$(TIMESTAMP)

CLEAN := \
	/tmp/* \
	/tmp/.[!.]* \
	/tmp/..?* \
	$(HOME)/*cache \
	$(HOME)/.*cache \
	$(HOME)/.local/*cache \
	$(HOME)/.local/.*cache \
	$(HOME)/.python_history \
	$(HOME)/.bash_history \
	$(HOME)/.sqlite_history \
	$(ADD_CLEAN)  # user defined env

BACKUP := \
  $(HOME)/.bashrc \
  $(HOME)/.config/git \
  $(HOME)/.config/vim \
  $(HOME)/.config/tmux \
	$(ADD_BACKUP)  # user defined env

PRIVATE_BACKUP := \
	$(HOME)/.ssh \
	$(ADD_PRIVATE_BACKUP)  # user defined env

default:
	@cat $(MAKEFILE) | less

clean:
	@rm -vrf $(CLEAN)

backup/all: backup backup/private

backup:
	@mkdir -vp '$(BACKUP_TARGET).temp'
	@echo '$(BACKUP)' | tr ' ' '\n' | \
		xargs -I '{}' -- cp -vr '{}' '$(BACKUP_TARGET).temp'
	@tar -czf '$(BACKUP_TARGET).tar.gz' '$(BACKUP_TARGET).temp' && \
		rm -vrf '$(BACKUP_TARGET).temp'

backup/private:
	@mkdir -vp '$(PRIVATE_BACKUP_TARGET).temp'
	@echo '$(PRIVATE_BACKUP)' | tr ' ' '\n' | \
		xargs -I '{}' -- cp -vr '{}' '$(PRIVATE_BACKUP_TARGET).temp'
	@tar -czf '$(PRIVATE_BACKUP_TARGET).tar.gz' '$(PRIVATE_BACKUP_TARGET).temp' && \
		rm -vrf '$(PRIVATE_BACKUP_TARGET).temp'
