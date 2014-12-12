require 'sinatra/base'
require 'sinatra/json'
require './src/db'

module Wpt
  class Web < Sinatra::Base
    TYPES = ['first', 'repeat']
    SERIES = [
      'load_time',
      'ttfb',
      'bytes_out',
      'boutes_out_doc',
      'bytes_in',
      'butes_in_doc',
      'connections',
      'requests',
      'requestsDoc',
      'responses_200',
      'responses_404',
      'responses_other',
      'result',
      'render',
      'fully_loaded',
      'cached',
      'doc_time',
      'dom_time',
      'score_cache',
      'score_cdn',
      'score_gzip',
      'score_cookies',
      'score_keep_alive',
      'score_minify',
      'score_combine',
      'score_compress',
      'score_etags',
      'gzip_total',
      'gzip_savings',
      'minify_total',
      'minify_savings',
      'image_total',
      'image_savings',
      'optimization_checked',
      'aft',
      'dom_elements',
      'page_speed_version',
      'title',
      'title_time',
      'load_event_start',
      'load_event_end',
      'dom_content_loaded_event_start',
      'dom_content_loaded_event_end',
      'last_visual_change',
      'browser_name',
      'browser_version',
      'server_count',
      'server_rtt',
      'base_page_cdn',
      'adult_site',
      'fixed_viewport',
      'score_progressive_jpeg',
      'first_paint',
      'doc_cpu_ms',
      'fully_loaded_cpu_ms',
      'doc_cpu_pct',
      'fully_loaded_cpu_pct',
      'is_responsive',
      'date',
      'speed_index',
      'visual_complete',
      'effective_bps',
      'effective_bpc_doc',
    ]

    def db
      @db ||= Db.new
    end

    get '/' do
      haml :index
    end

    get '/filters.json' do
      json({
        name: db.results.distinct.select(:name).map { |i| i[:name] },
        type: TYPES,
        series: SERIES
      })
    end

    get '/series.json' do
      json(
        db.results
          .where(name: params['app'], type: params['type'])
          .select(:date, params['series'].to_sym)
          .all)
    end
  end
end
