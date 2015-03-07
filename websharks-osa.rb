require "formula"

class WebsharksOsa < Formula
  # Formula source and info.
  homepage "https://github.com/websharks/osa"
  head "https://github.com/websharks/osa.git", :branch => "000000-dev"
  url "https://github.com/websharks/osa.git", :tag => "150307"

  # Terminal notifier used by some OSA scripts.
  depends_on "terminal-notifier" => :recommended

  # Allow installation to create symlinks pointing to a local copy of the repo.
  option "with-local", "Symlinks based on local copy of ~/WebSharks/osa"

  # Installation routine.
  def install # Install repo files.
    prefix.install Dir["*"] # Copy all files.

    # Define a few directory paths used below.

    local_repo_dir = File.expand_path("~/WebSharks/osa")
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

  test do # Test routine.
    # Not tests at this time.
  end
end
