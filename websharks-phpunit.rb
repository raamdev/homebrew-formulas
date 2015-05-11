require "formula"
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class WebsharksPhpunit < Formula
  homepage "https://phpunit.de/"
  url "https://phar.phpunit.de/phpunit.phar"
  version "4.6.0"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    mv "phpunit.phar", "phpunit-#{version}.phar"
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "phpunit", "--version"`
  end
end
