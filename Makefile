SOURCE_FILES = dig.sh icon.png icons/* info.plist
PKG_FILES = $(SOURCE_FILES)
EXTENSION = Dig.alfredworkflow
INSTALL_DIR = $(HOME)/Library/Application Support/Alfred/extensions/scripts/Gist
BUNDLEID = pjkh.dig
VERSION = 1.0

all: $(EXTENSION)

$(EXTENSION): $(SOURCE_FILES) VERSION
	zip -T $(EXTENSION) $(PKG_FILES)

VERSION:
	sed -i '' -e "s/{BUNDLEID}/$(BUNDLEID)/" info.plist

clean:
	rm -rf $(EXTENSION)

test:
	@roundup tests/test_*

local-install:
	cp $(PKG_FILES) "$(INSTALL_DIR)/"

