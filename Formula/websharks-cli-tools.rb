require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)
require File.expand_path("../../Requirements/Php/websharks-php-phar-requirement", __FILE__)

class WebsharksCliTools < Formula
  homepage "https://github.com/websharks/cli-tools"
  url "https://github.com/websharks/cli-tools/releases/download/150606/cli-tools.phar"
  version "150606"

  depends_on WebsharksPhpVersionRequirement
  depends_on WebsharksPhpPharRequirement
  depends_on "gnuplot" => :recommended

  def install
    mv "cli-tools.phar", "cli-tools-#{version}.phar"
    libexec.install "cli-tools-#{version}.phar"
    sh = libexec + "ws"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d ___cli.phar_proxy=\"$0\" -d allow_url_fopen=On -d detect_unicode=Off -d date.timezone=UTC #{libexec}/websharks-cli-tools-#{version}.phar \"$@\"")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "ws", "--version"`
  end
end
