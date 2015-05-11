require "formula"
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class WebsharksApigen < Formula
  homepage "https://github.com/ApiGen/ApiGen"
  url "http://apigen.org/apigen.phar"
  version "4.1.0"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    mv "apigen.phar", "apigen-#{version}.phar"
    libexec.install "apigen-#{version}.phar"
    sh = libexec + "apigen"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/apigen-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "apigen", "--version"`
  end
end
