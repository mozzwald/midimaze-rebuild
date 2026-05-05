MADS := mads
PYTHON := python3
ATARI800_AI := atari800-ai

ORIGINAL := ref/MIDI Maze-Original.rom
BUILD_DIR := build
BANKS := 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
BANK_BINS := $(addprefix $(BUILD_DIR)/bank,$(addsuffix .bin,$(BANKS)))
ROM := $(BUILD_DIR)/midimaze.rom

.PHONY: all clean compare run $(addprefix compare-bank,$(BANKS))

all: $(ROM)

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/bank%.bin: bank%.asm | $(BUILD_DIR)
	$(MADS) $< -o:$@

$(ROM): $(BANK_BINS)
	cat $^ > $@

compare: $(ROM)
	$(PYTHON) tools/compare_rom.py $< --original "$(ORIGINAL)"

compare-bank%: $(BUILD_DIR)/bank%.bin
	$(PYTHON) tools/compare_rom.py $< --original "$(ORIGINAL)" --bank $*

run: $(ROM)
	$(ATARI800_AI) -xl -ntsc -ai -cart $(ROM)

clean:
	rm -rf $(BUILD_DIR)
