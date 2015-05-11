require File.join(File.dirname(__FILE__), 'websharks-php-requirement')

class WebsharksPhpPharRequirement < WebsharksPhpRequirement
  def satisfied?
    `php -m`.downcase.include? "phar"
  end

  def message
    "PHP Phar support is required for this formula."
  end
end
