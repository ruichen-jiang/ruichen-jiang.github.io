JEMDOC := jemdoc
JEMDOC_FLAGS := -c site.conf
PAGES := index.html publications.html

.PHONY: all clean

all: $(PAGES)

%.html: %.jemdoc MENU jemdoc.css site.conf favicon.svg
	$(JEMDOC) $(JEMDOC_FLAGS) $<

clean:
	$(RM) $(PAGES)
