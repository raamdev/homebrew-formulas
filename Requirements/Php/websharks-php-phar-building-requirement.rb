require File.join(File.dirname(__FILE__), 'websharks-php-requirement')

class WebsharksPhpPharBuildingRequirement < WebSharksPhpRequirement
  def satisfied?
    `php -i| grep phar.readonly`.downcase.include? "off"
  end

  def message
    "The PHP setting 'phar.readonly' is required to be 'Off' for this formula."
  end
end
