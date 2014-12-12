module Wpt
  class Test
    RUNTEST_PATH = '/runtest.php'

    def initialize(endpoint:, name:, script:)
      @endpoint = endpoint
      @name = name
      @script = script
      @run_response = nil
      @results = nil
    end

    def runtest_uri
      URI(sprintf('%s%s', @endpoint, RUNTEST_PATH))
    end

    def run
      r = Net::HTTP.post_form(runtest_uri, {
        'url' => 'https://my.rightscale.com',
        'runs' => 1,
        'fvonly' => 0,
        'video' => 1,
        'f' => 'json',
        'script' => @script,
      })

      if r.code == '200'
        @run_response = JSON.parse(r.body)
      else
        raise sprintf("Test run failed! %s", r.message)
      end
    end

    def in_progress?
      r = JSON.parse(Net::HTTP.get(URI(@run_response['data']['jsonUrl'])))
      statusCode = r['data']['statusCode'] || r['statusCode']

      if statusCode < 200
        return true
      else
        @results = r
        return false
      end
    end

    def results
      @results
    end

    def average_first_view
      results['data']['average']['firstView'].merge({
        'name' => @name,
        'type' => 'first',
      })
    end

    def average_repeat_view
      results['data']['average']['repeatView'].merge({
        'name' => @name,
        'type' => 'repeat',
      })
    end
  end
end
