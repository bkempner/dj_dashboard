class SlowJob

  def perform
    puts 'sleeping for a long time'
    sleep(1800)
  end

end
