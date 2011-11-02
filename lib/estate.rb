class Estate
  CHARGE_PERIODS = [:quarterly, :yearly].freeze

  attr_reader :code, :charge_period, :due_dates

  def initialize(options)
    @code = options[:code]
    @charge_period = options[:charge_period]
    @due_dates = options[:due_dates]
  end
end
