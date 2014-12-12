module Wpt
  class Coordinator
    SLEEP_PERIOD = 5

    def initialize
      @tests = []
    end

    def add_test(test)
      @tests.push test
    end

    def start_tests
      @tests.each(&:run)
    end

    def wait_for_tests
      while true
        number_running = @tests.select(&:in_progress?).count
        break if number_running == 0

        puts sprintf("Waiting on %s test(s)...", number_running)
        sleep SLEEP_PERIOD
      end
    end

    def results
      results = @tests.map do |test|
        [ test.average_first_view, test.average_repeat_view ]
      end

      results.flatten
    end

    def run
      start_tests
      wait_for_tests

      puts "done"
    end
  end
end
