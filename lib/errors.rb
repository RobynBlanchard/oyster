class MaxTopUpError < StandardError
  def initialize
    super("Maximum top up is 50")
  end
end

class BalanceBelowRequiredError < StandardError
  def initialize
    super("Please top up")
  end
end
