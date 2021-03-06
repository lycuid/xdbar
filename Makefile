include config.mk

$(BIN): $(OBJS)
	mkdir -p $(@D) && $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

$(OBJS): $(IDIR)/config.h

$(ODIR)/%.o: $(IDIR)/%.c $(IDIR)/%.h
	mkdir -p $(@D) && $(CC) $(CFLAGS) -c -o $@ $<
$(ODIR)/%.o: $(IDIR)/%.c
	mkdir -p $(@D) && $(CC) $(CFLAGS) -c -o $@ $<

.PHONY: options
options:
	@echo "$(NAME) build options:"
	@echo "CC       = $(CC)"
	@echo "PKGS     = $(PKGS)"
	@echo "SRC      = $(SRC)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "----------------------------------"

.PHONY: install
install: options $(BIN)
	mkdir -p $(DESTDIR)$(BINPREFIX)
	strip $(BIN)
	cp -f $(BIN) $(DESTDIR)$(BINPREFIX)/$(NAME)
	chmod 755 $(DESTDIR)$(BINPREFIX)/$(NAME)

.PHONY: uninstall
uninstall:
	$(RM) $(DESTDIR)$(BINPREFIX)/$(NAME)

# misc.
.PHONY: fmt clean debug run
fmt: ; @git ls-files | egrep '\.[ch]$$' | xargs clang-format -i
clean: ; rm -rf $(BUILD)
run: $(BIN) ; $(BIN) $(ARGS)
debug: $(BIN) ; gdb $(BIN)
compile_flags: ; @echo $(CFLAGS) | tr ' ' '\n' > compile_flags.txt
