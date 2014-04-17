module IStats
  # CPU Stats
  # Extend CPU_STATS C module (ext/osx_stats/smc.c)
  class Cpu
    extend CPU_STATS
    class << self
      include IStats::Color

      def delegate(stat)
        case stat
        when 'all'
          all
        when 'temp', 'temperature'
          cpu_temperature
        else
          Command.help "Unknown stat for CPU: #{stat}"
        end
      end

      def all
        cpu_temperature
      end

      def cpu_temperature
        mode = "F"
        t = get_cpu_temp
        list = [0, 30, 55, 80, 100, 130]

        if mode == "F"
          t = fahrenheit t
          list.map { |i| fahrenheit(i) }
        end

        message = "CPU temp: #{t}#{Symbols.degree}#{mode}  "
        #sparkline = Sparkr.sparkline(list) do |tick, count, index|
          #if index.between?(0, 5) and t > ( list[5]*0.9 )
            #flash_red(tick)
          #elsif index.between?(0, 1)
            #green(tick)
          #elsif index.between?(2, 3) and t > ( list[3]*0.9 )
            #light_yellow(tick)
          #elsif index == 4 and t > ( list[4]*0.9 )
            #yellow(tick)
          #elsif index == 5 and t > ( list[5]*0.9 )
            #red(tick)
          #else
            #tick
          #end
        #end
        puts message # + sparkline
      end

      def fahrenheit(c)
        t = c*9/5+32
        t.round(2)
      end
    end
  end
end
