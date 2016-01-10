require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)
require File.expand_path("../../Requirements/Php/websharks-php-phar-requirement", __FILE__)

class WebsharksCliTools < Formula
  homepage "https://github.com/websharks/cli-tools"
  url "https://github.com/websharks/cli-tools/releases/download/160110/cli-tools.phar"
  sha256 "85aec45d4809ad5e818e2b8abce09a77cc11b75b570070704988d918bcb1fdd4"
  version "160110"

  depends_on WebsharksPhpVersionRequirement
  depends_on WebsharksPhpPharRequirement
  depends_on "gnuplot" => :recommended

  def install
    mv "cli-tools.phar", "cli-tools-#{version}.phar"
    libexec.install "cli-tools-#{version}.phar"
    sh = libexec + "ws"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d session.name=cli-phar-via::\"$0\" -d allow_url_fopen=on -d date.timezone=UTC #{libexec}/cli-tools-#{version}.phar \"$@\"")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "ws", "--version"`
  end
end
