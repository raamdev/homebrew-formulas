require File.join(File.dirname(__FILE__), 'websharks-php-requirement')

class WebsharksPhpVersionRequirement < WebsharksPhpRequirement
  def satisfied?
    %w{php54 php55 php56}.any? do |php|
        f = Formula[php]
        f.rack.directory? && f.rack.children.length > 0
    end
  end

  def message
    "Missing PHP54, PHP55 or PHP56 from homebrew-php. Please install one of them before continuing."
  end
end
