#
# NetSurf Project toolchain SDK build
#
# Required environment:
#
# GCCSDK_INSTALL_ENV      -- /path/to/install/prefix
# GCCSDK_INSTALL_CROSSBIN -- /path/to/toolchain/bin
#
# supported targets are:
#                       arm-riscos-gnueabi
#                       arm-unknown-riscos  
#                       m68k-atari-mint
#			m5475-atari-mint
#                       ppc-amigaos 
#                       i686-w64-mingw32    
#                       x86_64-w64-mingw32
#                       m68k-unknown-amigaos

ifeq ($(GCCSDK_INSTALL_ENV),)
  $(error GCCSDK_INSTALL_ENV not set)
endif

ifeq ($(GCCSDK_INSTALL_CROSSBIN),)
  $(error GCCSDK_INSTALL_CROSSBIN not set)
endif

# Upstream package versions

# Components for most (if not all) platforms

# Compression libraries

# https://github.com/google/brotli
VERSION_BROTLI := 1.2.0
CKSUM_BROTLI := 816c96e8e8f193b40151dad7e8ff37b1221d019dbcb9c35cd3fadbfe6477dfec
# https://zlib.net/
VERSION_ZLIB := 1.3.1
CKSUM_ZLIB := 9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23

# Cryptography

# https://openssl-library.org/
VERSION_OPENSSL := 3.5.4
CKSUM_OPENSSL := 967311f84955316969bdb1d8d4b983718ef42338639c621ec4c34fddef355e99

# Document parsers

# https://github.com/libexpat/libexpat
VERSION_LIBEXPAT := 2.7.3
CKSUM_LIBEXPAT := 821ac9710d2c073eaf13e1b1895a9c9aa66c1157a99635c639fbff65cdbdd732

# Image formats

# https://libjpeg-turbo.org/
VERSION_LIBJPEG_TURBO := 3.1.2
CKSUM_LIBJPEG_TURBO := 8f0012234b464ce50890c490f18194f913a7b1f4e6a03d6644179fa0f867d0cf
# http://www.libpng.org/pub/png/libpng.html
VERSION_LIBPNG := 1.6.53
CKSUM_LIBPNG := 1d3fb8ccc2932d04aa3663e22ef5ef490244370f4e568d7850165068778d98d4
# https://developers.google.com/speed/webp/
VERSION_LIBWEBP := 1.6.0
CKSUM_LIBWEBP := e4ab7009bf0629fd11982d4c2aa83964cf244cffba7347ecd39019a9e38c4564

# Network transports and name resolution

# https://c-ares.org/
# https://github.com/c-ares/c-ares/releases/download/
VERSION_LIBCARES := 1.34.5
CKSUM_LIBCARES := 7d935790e9af081c25c495fd13c2cfcda4792983418e96358ef6e7320ee06346
# https://curl.se/
VERSION_LIBCURL := 8.17.0
CKSUM_LIBCURL := e8e74cdeefe5fb78b3ae6e90cd542babf788fa9480029cfcee6fd9ced42b7910

############################################################################

# Platforms with no native iconv (AmigaOS, Atari, Windows)

# https://www.gnu.org/software/libiconv/
VERSION_LIBICONV := 1.18
CKSUM_LIBICONV := 3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8

# Platforms that don't use libjpeg-turbo (AmigaOS 3, Atari, Windows)

# http://libjpeg.sourceforge.net/
VERSION_LIBJPEG := 8d
CKSUM_LIBJPEG := 00029b1473f0f0ea72fbca3230e8cb25797fbb27e58ae2e46bb8bf5a806fe0b3

# AmigaOS only components

# http://mission-base.com/peter/source/
# 1.7.0: https://github.com/peterGraf/pbl/releases
VERSION_LIBPBL := 1_04
CKSUM_LIBPBL := 20f0ab1af09a22a8f3cb3ce3832247a6b51d8db57211f6bb0794af9485229a67
# https://github.com/laurikari/tre/
VERSION_LIBTRE := 0.9.0
CKSUM_LIBTRE := f57f5698cafdfe516d11fb0b71705916fe1162f14b08cf69d7cf86923b5a2477
#
VERSION_ROADSHOW := 7_64_0-amissl
CKSUM_ROADSHOW := 5af092c2319f184d49f5eda72d160231b3f3551f9884f8136c531521059a4ad2

# Atari only components

# https://www.freetype.org/
VERSION_FREETYPE := 2.14.1
CKSUM_FREETYPE := 174d9e53402e1bf9ec7277e22ec199ba3e55a6be2c0740cb18c0ee9850fc8c34

# https://github.com/berkus/hermes-pixel-format/archive/refs/tags/v1.3.3.tar.gz
VERSION_HERMES := 1.3.3
CKSUM_HERMES := e86374606105d2a251d4406e5f9fca8d09e2fd971ebb0dfd342e40953676c46e
#
VERSION_LDG := SVN-20150827
CKSUM_LDG := ca7959d31b46cb1e755005eddcc0daf6a91f7faad7d869d82e94d98d20650d94
# Git-20170304
VERSION_LIBCF := CVS-20130415
CKSUM_LIBCF := 5d25c4faa2f5b7fc106bb47d093646f79d0fa72a34aaf8122110a2e4cf9eb6cc
#
VERSION_WINDOM := 2.0.1
CKSUM_WINDOM := 2539c15c22f7b8ca48c015f0c3d33f3bd1666cc8aa56eef6f38de2cc98a3479e

# Windows only components

#
VERSION_LIBGNURX := 2.5.1
CKSUM_LIBGNURX := 7147b7f806ec3d007843b38e19f42a5b7c65894a57ffc297a76b0dcd5f675d76

############################################################################

# Path
path__ := $(GCCSDK_INSTALL_CROSSBIN):$(PATH)

# Tools
cc__ := $(word 1,$(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc))
cxx__ := $(word 1,$(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*g++))
ar__ := $(word 1,$(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ar))
ranlib__ := $(word 1,$(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ranlib))
windres__ := $(word 1,$(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*windres))

# Flags
cflags__ := -I$(GCCSDK_INSTALL_ENV)/include
cppflags__ := -I$(GCCSDK_INSTALL_ENV)/include
ldflags__ := -L$(GCCSDK_INSTALL_ENV)/lib
pkg_config_libdir__ := $(GCCSDK_INSTALL_ENV)/lib/pkgconfig

# Target
TARGET := $(shell $(cc__) -dumpmachine)

ifeq ($(findstring -riscos,$(TARGET)),-riscos)
  cflags__ := $(cflags__) -mpoke-function-name
  ifeq ($(findstring -gnueabi,$(TARGET)),-gnueabi)
    cflags__ := $(cflags__) -funwind-tables
  endif
endif

ifeq ($(TARGET),m68k-unknown-amigaos)
  cflags__ := $(cflags__) -fomit-frame-pointer -m68020-60 -msoft-float
endif

# Environment
# Newer autotools objects to -I appearing in CFLAGS
cleanenv := PATH="$(path__)" CC="$(cc__)" CXX="$(cxx__)" AR="$(ar__)" RANLIB="$(ranlib__)" CPPFLAGS="$(cppflags__)" LDFLAGS="$(ldflags__)" PKG_CONFIG_LIBDIR="$(pkg_config_libdir__)"
env := $(cleanenv) CFLAGS="$(cflags__)"

# Cross-compiling CMake invocation.
NS_SDK_CMAKE_CMD=cmake \
		-DCMAKE_INSTALL_PREFIX="$(GCCSDK_INSTALL_ENV)" \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_COLOR_MAKEFILE=OFF \
		-DBUILD_DOC=OFF \
		-DBUILD_DOCS=OFF \
		-DBUILD_EXAMPLE=OFF \
		-DBUILD_EXAMPLES=OFF \
		-DBUILD_TEST=OFF \
		-DBUILD_TESTS=OFF \
		-DBUILD_TESTING=OFF \

RECIPES := $(CURDIR)/recipes
SOURCEDIR := $(CURDIR)/sources
BUILDDIR := $(CURDIR)/builddir-$(TARGET)
BUILDSTEPS := $(BUILDDIR)/build-steps

# Tools
# patch: refuse to countenance fuzz
PATCH := patch -F0
FETCHSRC := $(CURDIR)/fetchsrc

# Compute the SDK components
SDK_ITEMS :=

COMMON_SDK_ITEMS := zlib.d openssl.d libpng.d libcares.d libcurl.d libexpat.d

LIBCURL_SSL := openssl
LIBCURL_DISABLES := $(patsubst %,--disable-%,ftp file dict ldap ldaps mqtt rtsp telnet gopher tftp pop3 imap smb smtp manual)
FREETYPE_ENV := LIBPNG_CFLAGS=$$($(GCCSDK_INSTALL_ENV)/bin/libpng-config --cflags) LIBPNG_LDFLAGS=$$($(GCCSDK_INSTALL_ENV)/bin/libpng-config --ldflags)

# Openssl target has to alter for mingw
TARGET_OPENSSL:=$(TARGET)

# Target Specific setup
ifeq ($(TARGET),arm-riscos-gnueabi)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libbrotli.d $(COMMON_SDK_ITEMS) libjpeg-turbo.d libwebp.d)
  EXTRAARGS_LIBCARES := --disable-shared 'ac_cv_have_decl_getservbyport_r=no'
  LIBCURL_ENV := LIBS="-lbrotlidec -lbrotlicommon"
  EXTRAARGS_LIBCURL := --enable-nonblocking --enable-ares --with-random="/dev/urandom" $(LIBCURL_DISABLES)
  EXTRAARGS_OPENSSL := no-asm
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif

ifeq ($(TARGET),arm-unknown-riscos)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, $(COMMON_SDK_ITEMS) libjpeg-turbo.d libwebp.d)
  EXTRAARGS_LIBCARES := --disable-shared 'ac_cv_have_decl_getservbyport_r=no'
  EXTRAARGS_LIBCURL := --enable-nonblocking --enable-ares --with-random="/dev/urandom" $(LIBCURL_DISABLES)
  EXTRAARGS_OPENSSL := no-asm
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif

ifeq ($(TARGET),m68k-atari-mint)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libiconv.d $(COMMON_SDK_ITEMS) libjpeg.d libcf.d ldg.d windom.d hermes.d freetype.d)
  EXTRAARGS_LIBCARES := --disable-shared 'ac_cv_have_decl_getservbyport_r=no'
  EXTRAARGS_LIBCURL := --enable-optimize --enable-nonblocking --enable-ares --with-random="/dev/urandom" --disable-manual --disable-curldebug --disable-thread --disable-threaded-resolver 
  EXTRAARGS_LIBICONV := --enable-extra-encodings
  LIBICONV_ENV := CFLAGS="-DPATH_MAX=1024"
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif

ifeq ($(TARGET),m5475-atari-mint)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libiconv.d $(COMMON_SDK_ITEMS) libjpeg.d libcf.d ldg.d windom.d hermes.d freetype.d)
  EXTRAARGS_LIBCARES := --disable-shared 'ac_cv_have_decl_getservbyport_r=no'
  EXTRAARGS_LIBCURL := --enable-optimize --enable-nonblocking --enable-ares --with-random="/dev/urandom" --disable-manual --disable-curldebug --disable-thread --disable-threaded-resolver
  EXTRAARGS_LIBICONV := --enable-extra-encodings
  LIBICONV_ENV := CFLAGS="-DPATH_MAX=1024"
  EXTRAARGS_OPENSSL := no-asm
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif

ifeq ($(TARGET),ppc-amigaos)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libiconv.d libtre.d libpbl.d $(COMMON_SDK_ITEMS) libjpeg-turbo.d)
  LIBCURL_SSL := amissl
  EXTRAARGS_LIBCARES := --disable-shared
  EXTRAARGS_LIBCURL := --disable-ntlm-wb --without-random --enable-threaded-resolver --disable-ipv6 LIBS=-lpthread
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif

ifeq ($(TARGET),m68k-unknown-amigaos)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, roadshow.d libiconv.d libtre.d libpbl.d $(COMMON_SDK_ITEMS) libjpeg.d)
  EXTRAARGS_LIBCARES := --disable-shared --without-random
  LIBCARES_ENV := LIBS="-lm -lnet -lunix"
  LIBCURL_SSL := amissl
  EXTRAARGS_LIBCURL := --disable-ntlm-wb --without-random --disable-threaded-resolver --with-zlib --disable-rt --disable-ipv6
  LIBICONV_ENV := CFLAGS="-DPATH_MAX=1024 -DRLIMIT_NOFILE=6"
  LIBJPEG_ENV := LDFLAGS="-lm"
  LIBJPEG_TURBO_ENV := LDFLAGS="-lm"
  # XXX: build openssl against bsdsocket.library?
  # ENV_OPENSSL := CFLAGS="-I$(GCCSDK_INSTALL_ENV)/netinclude" CPPFLAGS="-D__NO_NET_API"
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
  ifeq ($(LIBCURL_SSL),openssl)
    LIBCURL_ENV := LIBS="-lm -lnet"
  else
    LIBCURL_ENV := CFLAGS="-I$(GCCSDK_INSTALL_ENV)/netinclude -D__NO_NET_API -DHAVE_IOCTLSOCKET_CAMEL_FIONBIO" LIBS="-lm"
  endif
  # XXX: libgcc is meant to be implied, but for some reason that
  # results in ld evaluating it after libm and thus failing to find symbols.
  # Hack around it by forcing the link order here.
  LIBEXPAT_ENV := LDFLAGS="-lgcc -lm"
endif

ifeq ($(TARGET),i686-w64-mingw32)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libiconv.d libgnurx.d $(COMMON_SDK_ITEMS) libjpeg.d libwebp.d)
  EXTRAARGS_LIBCARES := --disable-shared
  EXTRAARGS_LIBCURL := --enable-nonblocking --enable-ares --disable-ldap --without-random
  LIBCURL_ENV := CFLAGS="-DCARES_STATICLIB" LIBS="-lgdi32 -lcrypt32 -liphlpapi"
  TARGET_OPENSSL := mingw
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK" WINDRES="$(windres__)"
  EXTRAARGS_OPENSSL := no-asm enable-capieng
endif

ifeq ($(TARGET),x86_64-w64-mingw32)
  SDK_ITEMS := $(addprefix $(BUILDSTEPS)/, libiconv.d libgnurx.d $(COMMON_SDK_ITEMS) libjpeg.d libwebp.d)
  EXTRAARGS_LIBCARES := --disable-shared
  EXTRAARGS_LIBCURL := --enable-nonblocking --enable-ares --disable-ldap --without-random
  LIBCURL_ENV := CFLAGS="-DCARES_STATICLIB" LIBS="-lgdi32 -lcrypt32 -liphlpapi"
  TARGET_OPENSSL := mingw64
  EXTRAARGS_OPENSSL := no-asm enable-capieng
  ENV_OPENSSL := CPPFLAGS="-DOPENSSL_NO_UNIX_SOCK"
endif


ifeq ($(SDK_ITEMS),)
  $(error Unable to compute SDK components for target $(TARGET))
endif

.PHONY: all clean distclean
all: $(SDK_ITEMS)

clean:
	rm -fr $(BUILDDIR)

distclean: clean
	rm -fr $(SOURCEDIR)

# Sourcedir
$(BUILDSTEPS)/sourcedir.d: $(BUILDSTEPS)/builddir.d | $(SOURCEDIR)
	touch $@

$(SOURCEDIR):
	mkdir -p $(SOURCEDIR)

# Builddir
$(BUILDSTEPS)/builddir.d: | $(BUILDSTEPS)
	touch $@

$(BUILDSTEPS):
	mkdir -p $(BUILDSTEPS)


define uc
$(shell echo $(1) | tr a-z A-Z)
endef

# Patch source code from sdk recipies
#
# 1: module name to patch
# 2: path to source code
define patch_source
$(if $(realpath $(RECIPES)/patches/$(1)),for p in `ls $(RECIPES)/patches/$(1)/*.p` ; do $(PATCH) -d $(2) -p0 <$$p ; done)
$(if $(realpath $(RECIPES)/patches/$(1)/$(TARGET)),for p in `ls $(RECIPES)/patches/$(1)/$(TARGET)/*.p` ; do $(PATCH) -d $(2) -p0 <$$p ; done)
endef

# rule to build patched sources from compressed tar
# if tar base is not expicitly specified the
# module name is used.
#
# 1: module name
# 2: module version
# 3: optional tar base
define patched_source_rule

# directory with patched source
BUILDDIR_$(call uc,$(1)) := $$(BUILDDIR)/$(1)/$(if $(3),$(3),$(1))-$(2)
# original source tar gz
SOURCETGZ_$(call uc,$(1)) := $$(SOURCEDIR)/$(1)-$(2).tar.gz
# patched source build step
BUILDSTEP_SRC_$(call uc,$(1)) := $$(BUILDSTEPS)/$(1)-src-$(2).d

$$(BUILDSTEPS)/$(1)-src-$(2).d: $$(SOURCEDIR)/$(1)-$(2).tar.gz
	mkdir -p $$(BUILDDIR)/$(1)
	$$(RM) -rf $$(BUILDDIR)/$(1)/$(if $(3),$(3),$(1))-$(2)
	cd $$(BUILDDIR)/$(1) && tar xaf $$<
	$$(call patch_source,$(1),$$(BUILDDIR)/$(1)/$(if $(3),$(3),$(1))-$(2))
	touch $$@
endef

#######
# zlib
#######

$(eval $(call patched_source_rule,zlib,$(VERSION_ZLIB)))

$(BUILDSTEPS)/zlib.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_ZLIB)
	cd $(BUILDDIR_ZLIB) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --static
	cd $(BUILDDIR_ZLIB) && $(env) make install
	touch $@

$(SOURCETGZ_ZLIB): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://zlib.net/fossils/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_ZLIB) $@


###########
# libiconv
###########

$(eval $(call patched_source_rule,libiconv,$(VERSION_LIBICONV)))

$(BUILDSTEPS)/libiconv.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBICONV)
	cd $(BUILDDIR_LIBICONV) && $(env) $(LIBICONV_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared $(EXTRAARGS_LIBICONV)
	cd $(BUILDDIR_LIBICONV) && $(env) make install
	touch $@

$(SOURCETGZ_LIBICONV): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://ftp.gnu.org/pub/gnu/libiconv/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_LIBICONV) $@


###########
# libgnurx
###########

$(BUILDSTEPS)/libgnurx.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libgnurx-src.d
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --enable-static --disable-shared
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) make
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) make install
	touch $@

$(BUILDSTEPS)/libgnurx-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz
	mkdir -p $(BUILDDIR)/libgnurx
	cd $(BUILDDIR)/libgnurx && tar xaf $(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz
	for p in $$(ls $(RECIPES)/patches/libgnurx/*.p) ; do $(PATCH) -d $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) -p0 <$$p ; done
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) libtoolize --copy
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) aclocal
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) autoconf
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) automake --add-missing
	touch $@

$(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://downloads.sourceforge.net/project/mingw/Other/UserContributed/regex/mingw-regex-$(VERSION_LIBGNURX)/mingw-libgnurx-$(VERSION_LIBGNURX)-src.tar.gz" $(CKSUM_LIBGNURX) $@


###################
# atari cf library
###################

$(BUILDSTEPS)/libcf.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libcf-src.d
	$(env) make -C $(BUILDDIR)/libcf/cflib-$(VERSION_LIBCF)/cflib CROSSPREFIX=${TARGET}- PREFIX=$(GCCSDK_INSTALL_ENV) CROSS=yes
	mkdir -p $(GCCSDK_INSTALL_ENV)/lib/mshort
	mkdir -p $(GCCSDK_INSTALL_ENV)/lib/m68020-60
	mkdir -p $(GCCSDK_INSTALL_ENV)/lib/m5475
	$(env) make -C $(BUILDDIR)/libcf/cflib-$(VERSION_LIBCF)/cflib CROSSPREFIX=${TARGET}- PREFIX=$(GCCSDK_INSTALL_ENV) CROSS=yes install
	touch $@

$(BUILDSTEPS)/libcf-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libcf-$(VERSION_LIBCF).tar.bz2
	$(RM) -rf $(BUILDDIR)/libcf
	mkdir -p $(BUILDDIR)/libcf
	cd $(BUILDDIR)/libcf && tar xaf $(SOURCEDIR)/libcf-$(VERSION_LIBCF).tar.bz2
	touch $@

$(SOURCEDIR)/libcf-$(VERSION_LIBCF).tar.bz2:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "http://vincent.riviere.free.fr/soft/m68k-atari-mint/archives/cflib-$(VERSION_LIBCF).tar.bz2" $(CKSUM_LIBCF) $@


#######################
# atari windom library
#######################

$(BUILDSTEPS)/windom.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/windom-src.d
	mkdir -p $(BUILDDIR)/windom
	cd $(BUILDDIR)/windom && unzip $(SOURCEDIR)/windom-$(VERSION_WINDOM).zip
	for p in `ls $(RECIPES)/patches/windom/*.p` ; do $(PATCH) -d $(BUILDDIR)/windom/windom-$(VERSION_WINDOM)-1 -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/windom/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/windom/$(TARGET)/*.p` ; do $(PATCH) -d $(BUILDDIR)/windom/windom-$(VERSION_WINDOM)-1 -p0 <$$p ; done
endif
	$(env) make -C $(BUILDDIR)/windom/windom-$(VERSION_WINDOM)-1/src -f gcc.mak CROSS=yes CROSSPREFIX=${TARGET} M68K_ATARI_MINT_CFLAGS="-I$(GCCSDK_INSTALL_ENV)/include/" 
	$(env) make -C $(BUILDDIR)/windom/windom-$(VERSION_WINDOM)-1/src -f gcc.mak CROSS=yes CROSSPREFIX=${TARGET} PREFIX=$(GCCSDK_INSTALL_ENV) install
	touch $@

$(BUILDSTEPS)/windom-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/windom-$(VERSION_WINDOM).zip
	touch $@

$(SOURCEDIR)/windom-$(VERSION_WINDOM).zip:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://downloads.sourceforge.net/project/windom/windom/$(VERSION_WINDOM)/windom-$(VERSION_WINDOM)-1.zip" $(CKSUM_WINDOM) $@


####################
# atari ldg library
####################

$(BUILDSTEPS)/ldg.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/ldg-src.d
	mkdir -p $(BUILDDIR)/ldg
	cd $(BUILDDIR)/ldg && tar xjf $(SOURCEDIR)/ldg-$(VERSION_LDG).tar.bz2
	$(env) make -C $(BUILDDIR)/ldg/ldg-$(VERSION_LDG)/src/devel -f gcc.mak CROSS=yes PREFIX=$(GCCSDK_INSTALL_ENV) CC=${TARGET}-gcc AR=${TARGET}-ar
	cp $(BUILDDIR)/ldg/ldg-$(VERSION_LDG)/lib/gcc/libldg.a $(GCCSDK_INSTALL_ENV)/lib/
	cp $(BUILDDIR)/ldg/ldg-$(VERSION_LDG)/include/ldg.h $(GCCSDK_INSTALL_ENV)/include/ldg.h
	mkdir -p $(GCCSDK_INSTALL_ENV)/include/ldg
	cp $(BUILDDIR)/ldg/ldg-$(VERSION_LDG)/include/ldg/mem.h $(GCCSDK_INSTALL_ENV)/include/ldg/
	touch $@

$(BUILDSTEPS)/ldg-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/ldg-$(VERSION_LDG).tar.bz2
	touch $@

$(SOURCEDIR)/ldg-$(VERSION_LDG).tar.bz2:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "http://vincent.riviere.free.fr/soft/m68k-atari-mint/archives/ldg-$(VERSION_LDG).tar.bz2" $(CKSUM_LDG) $@


####################
# hermes bitmap lib
####################

$(BUILDSTEPS)/hermes.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/hermes-src.d
	cd $(BUILDDIR)/hermes/hermes-pixel-format-$(VERSION_HERMES)
	for p in `ls $(RECIPES)/patches/hermes/*.p` ; do $(PATCH) -d $(BUILDDIR)/hermes/hermes-pixel-format-$(VERSION_HERMES) -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/hermes/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/hermes/$(TARGET)/*.p` ; do $(PATCH) -d $(BUILDDIR)/hermes/hermes-pixel-format-$(VERSION_HERMES) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/hermes/hermes-pixel-format-$(VERSION_HERMES) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --disable-x86asm
	cd $(BUILDDIR)/hermes/hermes-pixel-format-$(VERSION_HERMES) && $(env) make CFLAGS="-D__BIG_ENDIAN__" install
	touch $@

$(BUILDSTEPS)/hermes-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/hermes-$(VERSION_HERMES).tar.gz
	$(RM) -rf $(BUILDDIR)/hermes
	mkdir -p $(BUILDDIR)/hermes
	cd $(BUILDDIR)/hermes && tar xaf $(SOURCEDIR)/hermes-$(VERSION_HERMES).tar.gz
	touch $@

$(SOURCEDIR)/hermes-$(VERSION_HERMES).tar.gz:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/berkus/hermes-pixel-format/archive/refs/tags/v$(VERSION_HERMES).tar.gz" $(CKSUM_HERMES) $@


####################
# freetype font lib
####################

$(eval $(call patched_source_rule,freetype,$(VERSION_FREETYPE)))

$(BUILDSTEPS)/freetype.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/freetype-src-$(VERSION_FREETYPE).d
	cd $(BUILDDIR)/freetype/freetype-$(VERSION_FREETYPE) && $(env) $(FREETYPE_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/freetype/freetype-$(VERSION_FREETYPE) && $(env) make
	cd $(BUILDDIR)/freetype/freetype-$(VERSION_FREETYPE) && $(env) make install 
	touch $@

$(SOURCEDIR)/freetype-$(VERSION_FREETYPE).tar.gz: $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://download.savannah.gnu.org/releases/freetype/freetype-$(VERSION_FREETYPE).tar.gz" $(CKSUM_FREETYPE) $@


#####################
# amiga roadshow sdk
#####################

$(BUILDSTEPS)/roadshow.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/roadshow-src.d
	mkdir -p $(BUILDDIR)/Roadshow-SDK
	lha xw=$(BUILDDIR)/Roadshow-SDK $(SOURCEDIR)/Roadshow-SDK-NS-$(VERSION_ROADSHOW).lha
	mkdir -p $(GCCSDK_INSTALL_ENV)/netinclude
	cp -r $(BUILDDIR)/Roadshow-SDK/SDK/netinclude/* $(GCCSDK_INSTALL_ENV)/netinclude/
	touch $@

$(BUILDSTEPS)/roadshow-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/Roadshow-SDK-NS-$(VERSION_ROADSHOW).lha
	touch $@

$(SOURCEDIR)/Roadshow-SDK-NS-$(VERSION_ROADSHOW).lha:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/chris-y/curl/releases/download/curl-$(VERSION_ROADSHOW)/Roadshow-SDK-NS.lha" $(CKSUM_ROADSHOW) $@


########
# regex
########

$(BUILDSTEPS)/libtre.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libtre-src.d
	mkdir -p $(BUILDDIR)/libtre
	cd $(BUILDDIR)/libtre && tar xaf $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.gz
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && $(env) make install
	cp $(RECIPES)/files/libtre/regex.h $(GCCSDK_INSTALL_ENV)/include/regex.h
	touch $@

$(BUILDSTEPS)/libtre-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.gz
	touch $@

$(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.gz:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/laurikari/tre/releases/download/v$(VERSION_LIBTRE)/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_LIBTRE) $@


########
# libpbl
########

$(BUILDSTEPS)/libpbl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libpbl-src.d
	cd $(BUILDDIR)/libpbl/pbl_$(VERSION_LIBPBL)_04 && $(env) make install PREFIX=$(GCCSDK_INSTALL_ENV)
	touch $@

$(BUILDSTEPS)/libpbl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/pbl_$(VERSION_LIBPBL).tar.gz
	mkdir -p $(BUILDDIR)/libpbl
	cd $(BUILDDIR)/libpbl && tar xaf $(SOURCEDIR)/pbl_$(VERSION_LIBPBL).tar.gz
	for p in `ls $(RECIPES)/patches/libpbl/*.p` ; do $(PATCH) -d $(BUILDDIR)/libpbl/pbl_$(VERSION_LIBPBL)_04 -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/libpbl/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/libpbl/$(TARGET)/*.p` ; do $(PATCH) -d $(BUILDDIR)/libpbl/pbl_$(VERSION_LIBPBL)_04 -p0 <$$p ; done
endif
	touch $@

$(SOURCEDIR)/pbl_$(VERSION_LIBPBL).tar.gz:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://www.mission-base.com/peter/source/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_LIBPBL) $@


#########
# OpenSSL
#########

$(BUILDSTEPS)/openssl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl-src.d
ifeq ($(LIBCURL_SSL),openssl)
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && $(env) $(ENV_OPENSSL) ./Configure --prefix=$(GCCSDK_INSTALL_ENV) $(TARGET_OPENSSL) no-shared no-threads $(EXTRAARGS_OPENSSL)
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && $(env) make install
endif
	touch $@

# prepare the openssl source tree
$(BUILDSTEPS)/openssl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz
	mkdir -p $(BUILDDIR)/openssl
	$(RM) -rf $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL)
	cd $(BUILDDIR)/openssl && tar xaf $(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz
	$(call patch_source,openssl,$(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL))
ifneq ($(realpath $(RECIPES)/files/openssl/$(TARGET)),)
	cp -r $(RECIPES)/files/openssl/$(TARGET)/* $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL)
endif
	touch $@

# get the openssl source tar
$(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz:
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/openssl/openssl/releases/download/openssl-$(VERSION_OPENSSL)/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_OPENSSL) $@


#########
# libPNG
#########

$(eval $(call patched_source_rule,libpng,$(VERSION_LIBPNG)))

$(BUILDSTEPS)/libpng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEP_SRC_LIBPNG)
	cd $(BUILDDIR_LIBPNG) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR_LIBPNG) && $(env) make install
	touch $@

$(SOURCETGZ_LIBPNG): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://downloads.sourceforge.net/libpng/$(subst $(SOURCEDIR)/,,$@)" $(CKSUM_LIBPNG) $@


##########
# libjpeg
##########

$(eval $(call patched_source_rule,libjpeg,$(VERSION_LIBJPEG),jpeg))

$(BUILDSTEPS)/libjpeg.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBJPEG)
	cd $(BUILDDIR_LIBJPEG) && $(env) $(LIBJPEG_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR_LIBJPEG) && $(env) make install
	touch $@

$(SOURCETGZ_LIBJPEG): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk jpegsrc.v$(VERSION_LIBJPEG).tar.gz "https://ijg.org/files/jpegsrc.v$(VERSION_LIBJPEG).tar.gz" $(CKSUM_LIBJPEG) $@


###############
# libjpegturbo
###############

$(eval $(call patched_source_rule,libjpegturbo,$(VERSION_LIBJPEG_TURBO),libjpeg-turbo))

# build jpeg turbo library with cmake
$(BUILDSTEPS)/libjpeg-turbo.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBJPEGTURBO)
	mkdir -p $(BUILDDIR_LIBJPEGTURBO)/ns-sdk-build
	cd $(BUILDDIR_LIBJPEGTURBO)/ns-sdk-build && $(env) $(LIBJPEG_TURBO_ENV) $(NS_SDK_CMAKE_CMD) -DENABLE_STATIC=ON -DENABLE_SHARED=OFF ..
	cd $(BUILDDIR_LIBJPEGTURBO)/ns-sdk-build && $(env) make install VERBOSE=1
	touch $@

# jpeg turbo source tar
$(SOURCETGZ_LIBJPEGTURBO): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$(VERSION_LIBJPEG_TURBO)/libjpeg-turbo-$(VERSION_LIBJPEG_TURBO).tar.gz" $(CKSUM_LIBJPEG_TURBO) $@


############
# libbrotli
############

$(eval $(call patched_source_rule,brotli,$(VERSION_BROTLI)))

# build brotli with cmake
$(BUILDSTEPS)/libbrotli.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_BROTLI)
	mkdir -p $(BUILDDIR_BROTLI)/ns-sdk-build
	cd $(BUILDDIR_BROTLI)/ns-sdk-build && $(env) $(LIBBROTLI_ENV) $(NS_SDK_CMAKE_CMD) -DCMAKE_BUILD_TYPE=Release ..
	cd $(BUILDDIR_BROTLI)/ns-sdk-build && $(env) make install VERBOSE=1
	touch $@

# libbrotli tar
$(SOURCETGZ_BROTLI): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://github.com/google/brotli/archive/refs/tags/v$(VERSION_BROTLI).tar.gz" $(CKSUM_BROTLI) $@


##########
# libwebp
##########

$(eval $(call patched_source_rule,libwebp,$(VERSION_LIBWEBP)))

$(BUILDSTEPS)/libwebp.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBWEBP)
	cd $(BUILDDIR_LIBWEBP) && $(env) $(LIBWEBP_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared $(EXTRAARGS_LIBWEBP)
	cd $(BUILDDIR_LIBWEBP) && $(env) make install
	touch $@

$(SOURCETGZ_LIBWEBP): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk $(subst $(SOURCEDIR)/,,$@) "https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$(VERSION_LIBWEBP).tar.gz" $(CKSUM_LIBWEBP) $@


###########
# libcares
###########

$(eval $(call patched_source_rule,libcares,$(VERSION_LIBCARES),c-ares))

$(BUILDSTEPS)/libcares.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBCARES)
	cd $(BUILDDIR_LIBCARES) && $(cleanenv) $(LIBCARES_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) $(EXTRAARGS_LIBCARES)
	cd $(BUILDDIR_LIBCARES) && $(cleanenv) make install
	touch $@

$(SOURCETGZ_LIBCARES): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk c-ares-$(VERSION_LIBCARES).tar.gz "https://github.com/c-ares/c-ares/releases/download/v$(VERSION_LIBCARES)/c-ares-$(VERSION_LIBCARES).tar.gz" $(CKSUM_LIBCARES) $@


##########
# libcurl
##########

$(eval $(call patched_source_rule,libcurl,$(VERSION_LIBCURL),curl))

$(BUILDSTEPS)/libcurl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl.d $(BUILDSTEPS)/libcares.d $(BUILDSTEP_SRC_LIBCURL)
	cd $(BUILDDIR_LIBCURL) && $(env) CFLAGS="" $(LIBCURL_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --with-$(LIBCURL_SSL) --without-libidn2 --without-libpsl ${EXTRAARGS_LIBCURL}
	cd $(BUILDDIR_LIBCURL) && $(env) make install
	touch $@

$(SOURCETGZ_LIBCURL): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk curl-$(VERSION_LIBCURL).tar.bz2 "https://curl.se/download/curl-$(VERSION_LIBCURL).tar.bz2" $(CKSUM_LIBCURL) $@


###########
# libexpat
###########

$(eval $(call patched_source_rule,libexpat,$(VERSION_LIBEXPAT),expat))

$(BUILDSTEPS)/libexpat.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEP_SRC_LIBEXPAT)
	cd $(BUILDDIR_LIBEXPAT) && $(env) $(LIBEXPAT_ENV) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR_LIBEXPAT) && $(env) $(LIBEXPAT_ENV) make install
	touch $@

$(SOURCETGZ_LIBEXPAT): $(BUILDSTEPS)/sourcedir.d
	$(FETCHSRC) sdk expat-$(VERSION_LIBEXPAT).tar.bz2 "https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(VERSION_LIBEXPAT))/expat-$(VERSION_LIBEXPAT).tar.bz2" $(CKSUM_LIBEXPAT) $@

