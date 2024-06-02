# Define variables
REPO_DIR := $(CURDIR)
FLAKE := $(REPO_DIR)/#nixos

# Default target
all: update-system

# Target to update the repository and rebuild the system
update-system:
	@echo "Pulling latest changes in repository..."
	cd $(REPO_DIR) && git pull
	@echo "Rebuilding system configuration..."
	cd $(REPO_DIR) && sudo nixos-rebuild switch --flake $(FLAKE)
	@echo "Rebooting system..."
	sudo reboot now

# PHONY targets
.PHONY: all update-system
