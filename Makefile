
.PHONY: snap
snap:
	snapcraft --verbose --build-for=$(shell dpkg --print-architecture)

.PHONY: clean
clean:
	snapcraft clean
	rm -f *.snap

.PHONY: install
install:
	snap install --dangerous *.snap


