MADS := mads
PYTHON := python3
ATARI800_AI := atari800-ai

ORIGINAL := ref/MIDI Maze-Original.rom
BUILD_DIR := build
BANK_DIR := src/banks
BANKS := 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
BANK_BINS := $(addprefix $(BUILD_DIR)/bank,$(addsuffix .bin,$(BANKS)))
BANK_LSTS := $(addprefix $(BUILD_DIR)/bank,$(addsuffix .lst,$(BANKS)))
ROM := $(BUILD_DIR)/midimaze.rom
INCLUDES := include/atari_os.inc include/hardware.inc include/cartridge.inc

.PHONY: all clean compare listing run $(addprefix compare-bank,$(BANKS))

all: $(ROM)

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/bank%.bin: $(BANK_DIR)/bank%.asm $(INCLUDES) | $(BUILD_DIR)
	$(MADS) $< -o:$@

$(BUILD_DIR)/bank%.lst: $(BANK_DIR)/bank%.asm $(INCLUDES) | $(BUILD_DIR)
	$(MADS) $< -o:$(BUILD_DIR)/bank$*.bin -l:$@

$(ROM): $(BANK_BINS)
	cat $^ > $@

compare: $(ROM)
	$(PYTHON) tools/compare_rom.py $< --original "$(ORIGINAL)" --listings "$(BUILD_DIR)" --source-dir "$(BANK_DIR)"

compare-bank%: $(BUILD_DIR)/bank%.bin
	$(PYTHON) tools/compare_rom.py $< --original "$(ORIGINAL)" --bank $* --listings "$(BUILD_DIR)" --source-dir "$(BANK_DIR)"

listing: $(BANK_LSTS)

run: $(ROM)
	$(ATARI800_AI) -xl -ntsc -ai -cart $(ROM)

clean:
	rm -rf $(BUILD_DIR)
