require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)

class WebsharksOsa < Formula
  homepage "https://github.com/websharks/osa"
  head "https://github.com/websharks/osa.git", :branch => "000000-dev"
  url "https://github.com/websharks/osa.git", :tag => "150307"

  depends_on WebsharksPhpVersionRequirement
  depends_on "terminal-notifier" => :recommended

  option "with-local", "Symlinks based on local copy of ~/Projects/websharks/osa"

  def install
    prefix.install Dir["*"]

    # Define a few directory paths used below.

    local_repo_dir = File.expand_path("~/Projects/websharks/osa")
    script_libraries_dir = File.expand_path("~/Library/Script Libraries")
    typinator_scripts_dir = File.expand_path("~/Library/Application Support/Typinator/Sets/Includes/Scripts")
    services_dir = File.expand_path("~/Library/Services")

    # Establish installation source directory.

    install_from_dir = "#{prefix}" # Default behavhior.

    if build.with? "local" # From local repo?
      if File.directory? "#{local_repo_dir}"
        install_from_dir = "#{local_repo_dir}"
      end # Only if directory exists.
    end # Use local repo.

    # Create directories if they don't exist yet.

    if !File.directory? "#{script_libraries_dir}"
      FileUtils.mkdir_p "#{script_libraries_dir}"
    end # Create directory if not exists.

    if !File.directory? "#{typinator_scripts_dir}"
      FileUtils.mkdir_p "#{typinator_scripts_dir}"
    end # Create directory if not exists.

    if !File.directory? "#{services_dir}"
      FileUtils.mkdir_p "#{services_dir}"
    end # Create directory if not exists.

    # Install script libraries.

    if File.directory? "#{script_libraries_dir}"
      FileUtils.rm_f "#{script_libraries_dir}/websharks-osa"
      FileUtils.ln_s "#{install_from_dir}", "#{script_libraries_dir}/websharks-osa"
    end

    # Install typinator script handler.

    if File.directory? "#{typinator_scripts_dir}"
      FileUtils.rm_f "#{typinator_scripts_dir}/wsOSA"
      FileUtils.ln_s "#{install_from_dir}/scripts/typinator/wsOSA.bash", "#{typinator_scripts_dir}/wsOSA"
    end

    # Install services powered by OSA libs.

    if File.directory? "#{services_dir}"
      Dir["#{services_dir}/wsOSA.*.workflow"].each do |_workflow|
        FileUtils.rm_rf "#{_workflow}" # Delete recursively.
      end # It's a workflow; i.e. a directory.

      Dir["#{install_from_dir}/services/*.workflow"].each do |_workflow|
        _workflow_basename = File.basename("#{_workflow}") # e.g. `Something.workflow`
        FileUtils.cp_r "#{_workflow}", "#{services_dir}/wsOSA.#{_workflow_basename}"
      end # Copies service workflow files.
    end
  end

  test do
  end
end
