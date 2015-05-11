require File.join(File.dirname(__FILE__), 'websharks-php-requirement')

class WebsharksPhpRequirement < Requirement
  def fatal?
    true
  end

  def satisfied?
    false
  end

  def message
    "A requirement as failed."
  end
end
