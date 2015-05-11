require "formula"
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class WebsharksPhpCsFixer < Formula
  homepage "https://github.com/FriendsOfPHP/PHP-CS-Fixer"
  url "http://get.sensiolabs.org/php-cs-fixer.phar"
  version "1.7"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    mv "php-cs-fixer.phar", "php-cs-fixer-#{version}.phar"
    libexec.install "php-cs-fixer-#{version}.phar"
    sh = libexec + "php-cs-fixer"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/php-cs-fixer-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "php-cs-fixer", "--version"`
  end
end
