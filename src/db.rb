module Wpt
  class Db
    def initialize(create:nil)
      @db = Sequel.connect('sqlite://results.db')

      create_tables if create
    end

    def results
      @db[:results]
    end

    def create_tables
      @db.create_table :results do
        primary_key :id
        String :name
        String :type
        String :url
        Integer :load_time
        Integer :ttfb
        Integer :bytes_out
        Integer :boutes_out_doc
        Integer :bytes_in
        Integer :butes_in_doc
        Integer :connections
        Integer :requests
        Integer :requestsDoc
        Integer :responses_200
        Integer :responses_404
        Integer :responses_other
        Integer :result
        Integer :render
        Integer :fully_loaded
        Integer :cached
        Integer :doc_time
        Integer :dom_time
        Integer :score_cache
        Integer :score_cdn
        Integer :score_gzip
        Integer :score_cookies
        Integer :score_keep_alive
        Integer :score_minify
        Integer :score_combine
        Integer :score_compress
        Integer :score_etags
        Integer :gzip_total
        Integer :gzip_savings
        Integer :minify_total
        Integer :minify_savings
        Integer :image_total
        Integer :image_savings
        Integer :optimization_checked
        Integer :aft
        Integer :dom_elements
        Integer :page_speed_version
        Integer :title
        Integer :title_time
        Integer :load_event_start
        Integer :load_event_end
        Integer :dom_content_loaded_event_start
        Integer :dom_content_loaded_event_end
        Integer :last_visual_change
        String :browser_name
        Integer :browser_version
        Integer :server_count
        Integer :server_rtt
        String :base_page_cdn
        Integer :adult_site
        Integer :fixed_viewport
        Integer :score_progressive_jpeg
        Integer :first_paint
        Integer :doc_cpu_ms
        Integer :fully_loaded_cpu_ms
        Integer :doc_cpu_pct
        Integer :fully_loaded_cpu_pct
        Integer :is_responsive
        Integer :date
        Integer :speed_index
        Integer :visual_complete
        Integer :effective_bps
        Integer :effective_bpc_doc
      end
    end
  end
end
