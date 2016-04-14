require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)
require File.expand_path("../../Requirements/Php/websharks-php-phar-requirement", __FILE__)
require File.expand_path("../../Requirements/Php/websharks-php-phar-building-requirement", __FILE__)

class WebsharksPhing < Formula
  homepage "https://www.phing.info/"
  url "http://www.phing.info/get/phing-2.14.0.phar"
  sha256 "d93b31da0d9a2634089beab1ea776e53b4ee809395334f38529e8acdf4b88735"
  version "2.14.0"

  depends_on WebsharksPhpVersionRequirement
  depends_on WebsharksPhpPharRequirement
  depends_on WebsharksPhpPharBuildingRequirement

  def install
    mv "phing-latest.phar", "phing-#{version}.phar"
    libexec.install "phing-#{version}.phar"
    sh = libexec + "phing"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/phing-#{version}.phar \"$@\"")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "phing", "-version"`
  end
end
