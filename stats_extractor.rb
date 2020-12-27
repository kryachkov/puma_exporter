class StatsExtractor
  STATS_OF_INTEREST = %w(backlog running pool_capacity max_threads).freeze

  def initialize(puma_stats)
    @puma_stats = puma_stats
    @gathered_stats = {}
  end

  def perform
    if puma_stats['worker_status']
      puma_stats['worker_status'].each do |worker_status|
        gathered_stats[worker_status['index']] = worker_status['last_status'].slice(*STATS_OF_INTEREST)
      end
    else
      gathered_stats[0] = puma_stats.slice(*STATS_OF_INTEREST)
    end

    gathered_stats.map do |index, worker_stats|
      worker_stats.map do |k, v|
        "puma_#{k}{worker_index=#{index}} #{v}"
      end
    end.flatten
  end

  private

  attr_reader :gathered_stats, :puma_stats
end
