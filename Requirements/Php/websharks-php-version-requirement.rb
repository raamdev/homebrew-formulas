require File.join(File.dirname(__FILE__), 'websharks-php-requirement')

class WebsharksPhpVersionRequirement < WebsharksPhpRequirement
  def satisfied?
    %w{php70 php56 php55}.any? do |php|
        f = Formula[php]
        f.rack.directory? && f.rack.children.length > 0
    end
  end

  def message
    "Missing PHP70, PHP56, or PHP55 from homebrew-php. Please install one of them before continuing."
  end
end
