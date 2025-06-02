# Directories
DIST_DIR := dist
BIN_DIR := $(DIST_DIR)/bin

# Files
SRC := hello-test.c
EXEC := hello-test
RUN_SCRIPT := run.sh

# Default target
all: $(BIN_DIR)/$(EXEC) $(DIST_DIR)/run.sh

# Create bin and dist directories
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(DIST_DIR):
	mkdir -p $(DIST_DIR)

# Build the C program
$(BIN_DIR)/$(EXEC): $(SRC) | $(BIN_DIR)
	gcc $(SRC) -o $(BIN_DIR)/$(EXEC)

# Copy run.sh to dist and make it executable
$(DIST_DIR)/run.sh: $(RUN_SCRIPT) | $(DIST_DIR)
	cp $(RUN_SCRIPT) $(DIST_DIR)/run.sh
	chmod +x $(DIST_DIR)/run.sh

# Clean build artifacts
clean:
	rm -rf $(DIST_DIR)
