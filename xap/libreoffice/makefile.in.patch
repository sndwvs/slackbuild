--- Makefile.in	2018-12-20 01:19:41.000000000 +0100
+++ Makefile.in.new	2019-01-18 22:09:35.713586518 +0100
@@ -9,7 +9,7 @@
 
 gb_Top_MODULE_CHECK_TARGETS := slowcheck unitcheck subsequentcheck perfcheck uicheck screenshot
 
-.PHONY : all check-if-root bootstrap gbuild build build-non-l10n-only build-l10n-only check clean clean-build clean-host test-install distclean distro-pack-install docs download etags fetch get-submodules id install install-gdb-printers install-strip tags debugrun help showmodules translations packageinfo internal.clean $(gb_Top_MODULE_CHECK_TARGETS)
+.PHONY : all bootstrap gbuild build build-non-l10n-only build-l10n-only check clean clean-build clean-host test-install distclean distro-pack-install docs download etags fetch get-submodules id install install-gdb-printers install-strip tags debugrun help showmodules translations packageinfo internal.clean $(gb_Top_MODULE_CHECK_TARGETS)
 
 MAKECMDGOALS?=all
 build_goal:=$(if $(filter build check,$(MAKECMDGOALS)),all)\
@@ -59,14 +59,6 @@
 
 all: build
 
-check-if-root:
-	@if test ! `uname` = 'Haiku' -a `id -u` = 0 && ! grep -q 'lxc\|docker' /proc/self/cgroup; then \
-		echo; \
-		echo 'Building LibreOffice as root is a very bad idea, use a regular user.'; \
-		echo; \
-		exit 1; \
-	fi
-
 gb_Side ?= host
 
 include $(BUILDDIR)/config_$(gb_Side).mk
@@ -272,7 +264,7 @@
 #
 # Bootstrap
 #
-bootstrap: check-if-root compilerplugins
+bootstrap: compilerplugins
 
 #
 # Build
