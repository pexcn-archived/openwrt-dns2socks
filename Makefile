include $(TOPDIR)/rules.mk

PKG_NAME:=dns2socks
PKG_VERSION:=2.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pexcn/dns2socks.git
PKG_SOURCE_VERSION:=a47341dde5bac4ee76248ce8c52e7cc9479507d0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=pexcn <i@pexcn.me>

include $(INCLUDE_DIR)/package.mk

define Package/dns2socks
	SECTION:=net
	CATEGORY:=Network
	TITLE:=DNS to SOCKS or HTTP proxy
	URL:=https://sourceforge.net/projects/dns2socks/
	DEPENDS:=+libpthread
endef

define Package/dns2socks/description
This is a command line utility to resolve DNS requests via a SOCKS tunnel like Tor or a HTTP proxy.
endef

define Package/dns2socks/conffiles
/etc/config/dns2socks
endef

MAKE_PATH := DNS2SOCKS

define Package/dns2socks/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/DNS2SOCKS/dns2socks $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/dns2socks.init $(1)/etc/init.d/dns2socks
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/dns2socks.config $(1)/etc/config/dns2socks
endef

$(eval $(call BuildPackage,dns2socks))
