require 'bundler/setup'
require 'irb'
require 'speedtest_net'

def run_test(iterations = 1, delay = 0)
  iterations.times do |i|
    time = Time.now
    result = SpeedtestNet.run

    open('files/network_speeds.csv', 'a') do |f|
      f.puts "'#{time}',#{result.pretty_download},#{result.pretty_upload},#{result.pretty_latency}"
    end

    # open('network_speeds_full.csv', 'a') do |f|
    #   f.puts "Time," + result.array_keys.join(',')
    # end

    open('files/network_speeds_full.csv', 'a') do |f|
      f.puts "#{time}," + result.to_array.join(',')
    end

    puts "[#{Time.now}] Download: #{result.pretty_download}. Upload: #{result.pretty_upload}. Latency: #{result.pretty_latency}"
    sleep(delay) if iterations - i > 1
  end
end

# Start IRB
IRB.start(__FILE__)
