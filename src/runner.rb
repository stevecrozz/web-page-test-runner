module Wpt
  class Runner
    def initialize(scripts:, endpoint:)
      @scripts = scripts
      @endpoint = endpoint


      @coordinator = Wpt::Coordinator.new
      @db = Wpt::Db.new(create: false)
      @saver = Wpt::Saver.new(@db.results)
    end

    def build_test(file:)
      name = File.basename(file, '.script')
      script = File.read(file)

      Wpt::Test.new(
        endpoint: @endpoint,
        name: name,
        script: script
      )
    end

    def run
      @scripts.each do |file|
        @coordinator.add_test(build_test(file: file))
      end

      @coordinator.run
      @coordinator.results.each do |result|
        @saver.save(result)
      end
    end
  end
end
