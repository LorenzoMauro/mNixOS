#before running this makefile, enter a shell
# nix-shell -p gnumake git home-manager


# Define variables
REPO_DIR := $(CURDIR)
FLAKE := .#nixos

# Default target
all: update-system

# Target to update the repository and rebuild the system
update-system:
	@echo "Pulling latest changes in repository..."
	cd $(REPO_DIR) && git pull
	@echo "Rebuilding system configuration..."
	cd $(REPO_DIR) && sudo nixos-rebuild switch --flake $(FLAKE)
	@echo "Configuring Home Manager..."
	home-manager switch --flake .#lorenzo@nixos
	@echo "Rebooting system..."
	sudo reboot now

# PHONY targets
.PHONY: all update-system
