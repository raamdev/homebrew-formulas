require "formula"

class WebsharksOsa < Formula
  version "latest" # Latest version.
  homepage "https://github.com/websharks/osa"
  head "https://github.com/websharks/osa.git", :branch => "000000-dev"
  url "https://github.com/websharks/osa.git", :branch => "master"

  option "with-x", "Unused at this time."

  def install
    prefix.install Dir["*"] # Copy all files.

    script_libraries_dir = File.expand_path("~/Library/Script Libraries")
    typinator_scripts_dir1 = File.expand_path("~/Typinator/Includes/Scripts")
    typinator_scripts_dir2 = File.expand_path("~/Library/Application Support/Typinator/Sets/Includes/Scripts")

    if !File.directory? "#{script_libraries_dir}"
      mkdir "#{script_libraries_dir}"
    end # Create directory if not exists.

    ln_s "#{prefix}", "#{script_libraries_dir}/websharks", :force => true

    if File.directory? "#{typinator_scripts_dir1}"
      ln_s "#{prefix}/scripts/typinator.bash", "#{typinator_scripts_dir1}/runOSA", :force => true
    end
    if File.directory? "#{typinator_scripts_dir2}"
      ln_s "#{prefix}/scripts/typinator.bash", "#{typinator_scripts_dir2}/runOSA", :force => true
    end
  end

  test do
  end
end
