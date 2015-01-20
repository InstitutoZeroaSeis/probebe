class TimelineStep
  def initialize(steps = 20)
    @steps = steps
    @steps_enumerator = (1..@steps).cycle
  end

  def next_step
    format_step @steps_enumerator.next
  end

  protected

  def format_step(step)
    step.to_s.rjust(2, '0')
  end
end
