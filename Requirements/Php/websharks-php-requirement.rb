require "requirement"

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
