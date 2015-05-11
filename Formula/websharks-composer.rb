require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)
require File.expand_path("../../Requirements/Php/websharks-php-phar-requirement", __FILE__)

class WebsharksComposer < Formula
  homepage "https://getcomposer.org/download/"
  url "https://getcomposer.org/composer.phar"
  version "1.0-dev"

  depends_on WebSharksPhpVersionRequirement
  depends_on WebSharksPhpPharRequirement

  def install
    mv "composer.phar", "composer-#{version}.phar"
    libexec.install "composer-#{version}.phar"
    sh = libexec + "composer"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/composer-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "composer", "--version"`
  end
end
