.PHONY: put

put:
	rsync -vrt --delete --exclude=.git \
	. /Volumes/Elder\ Scrolls\ Online/live/AddOns/ZZEditBox

