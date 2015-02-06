require "formula"

class WebsharksOsa < Formula
  homepage "https://github.com/websharks/osa"
  head "https://github.com/websharks/osa.git", :branch => "000000-dev"
  url "https://github.com/websharks/osa.git", :tag => "150206"

  option "with-local", "Symlinks based on local copy of ~/WebSharks/osa"

  def install
    prefix.install Dir["*"] # Copy all files.

    local_repo_dir = File.expand_path("~/WebSharks/osa")
    script_libraries_dir = File.expand_path("~/Library/Script Libraries")
    typinator_scripts_dir1 = File.expand_path("~/Typinator/Includes/Scripts")
    typinator_scripts_dir2 = File.expand_path("~/Library/Application Support/Typinator/Sets/Includes/Scripts")
    services_dir = File.expand_path("~/Library/Services")

    install_from_dir = "#{prefix}" # Default behavhior.

    if build.with? "local" # From local repo?
      if File.directory? "#{local_repo_dir}"
        install_from_dir = "#{local_repo_dir}"
      end # Only if directory exists.
    end # Use local repo.

    FileUtils.rm_f "#{script_libraries_dir}/websharks"
    FileUtils.rm_f "#{typinator_scripts_dir1}/runOSA"
    FileUtils.rm_f "#{typinator_scripts_dir2}/runOSA"

    if !File.directory? "#{script_libraries_dir}"
      FileUtils.mkdir "#{script_libraries_dir}"
    end # Create directory if not exists.

    if !File.directory? "#{services_dir}"
      FileUtils.mkdir "#{services_dir}"
    end # Create directory if not exists.

    if File.directory? "#{script_libraries_dir}"
      FileUtils.rm_f "#{script_libraries_dir}/websharks-osa"
      FileUtils.ln_s "#{install_from_dir}", "#{script_libraries_dir}/websharks-osa"
    end

    if File.directory? "#{typinator_scripts_dir1}"
      FileUtils.rm_f "#{typinator_scripts_dir1}/wsOSA"
      FileUtils.ln_s "#{install_from_dir}/scripts/typinator-osa.bash", "#{typinator_scripts_dir1}/wsOSA"
    end

    if File.directory? "#{typinator_scripts_dir2}"
      FileUtils.rm_f "#{typinator_scripts_dir2}/wsOSA"
      FileUtils.ln_s "#{install_from_dir}/scripts/typinator-osa.bash", "#{typinator_scripts_dir2}/wsOSA"
    end

    if File.directory? "#{services_dir}"

      Dir["#{services_dir}/wsOSA.*.workflow"].each do |_file|
        FileUtils.rm_rf "#{_file}"
      end # It's a hard link; the `r` option is necessary.

      Dir["#{install_from_dir}/services/*.workflow"].each do |_file|
        _basename = File.basename("#{_file}") # e.g. Something.workflow
        FileUtils.ln "#{_file}", "#{services_dir}/wsOSA.#{_basename}", :force => true
      end

    end
  end

  test do
  end
end
