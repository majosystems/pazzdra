
module Pazzdra
  class Calc
    COMBO_UP_BASE = 0.25 # コンボ時の追加倍率（1コンボにつき）
    LENGTH_UP_BASE = 0.25 # 同時消しの長さによる増加率（1個につき）
    DROP_PLUS_UP_BASE = 0.06 # 強化ドロップによる増加率（1個につき）
    DROP_COLORS = [:r,:g,:b,:y,:p,:h] # 色指定のsymbol定義
    attr_accessor :data
    class << Calc
      # 単に引数全てを掛け合わせるだけの簡単なお仕事
      def cal(*ups)
        ups.compact.inject(1){|base, i| base.to_f * i.to_f }.round
      end
      # 何も指定しない場合の値
      def DEFAULT_BASE
        { base: 0, leader: 1, friend: nil, skill: nil, up_drops: nil, combo: nil }
      end
    end

    def initialize(data=nil)
      self.data = data
    end

    def data=(data)
      data ||= Calc.DEFAULT_BASE
      @data = data
    end

    def merge(data={})
      @data.merge!(data)
    end

    def show
      p @data
      p cal
    end

    # データを元に計算する
    def cal(data={})
      merge data
      case @data[:base]
      when Numeric
        Calc.cal @data[:base], @data[:leader], @data[:friend], @data[:skill], combo_up_pct
      when Array
        dragons = []
        @data[:base].each do |val|
          dragon = {}
          DROP_COLORS.each do |key|
            next unless val[key]
            dragon[key] = Calc.cal attack_power_with_all_pct(val[key], key),
              @data[:leader], @data[:friend], @data[:skill], combo_up_pct
            next unless val[:sub]
            dragon[:sub] = {}
            dragon[:sub][val[:sub]] = Calc.cal attack_power_with_all_pct((val[key].to_f / 2).to_i, val[:sub]),
              @data[:leader], @data[:friend], @data[:skill], combo_up_pct
          end
          dragons.push(dragon)
        end
        dragons
      end
    end

    private
    # コンボ数による倍率
    def combo_up_pct
      return 1 unless @data[:combo]
      1 + ((combo_count - 1) * COMBO_UP_BASE)
    end

    # コンボ総数
    def combo_count(color=nil)
      case @data[:combo]
      when Numeric
        @data[:combo].to_i
      when Hash
        if color
          return @data[:combo][color].count if @data[:combo][color]
          return 0
        end
        total_count = 0
        DROP_COLORS.each do |key|
          total_count += @data[:combo][key].count if @data[:combo][key]
        end
        total_count
      else
        1
      end
    end

    # 繋げた長さと強化ドロップを考慮したベース攻撃力
    def attack_power_with_all_pct(base_power, color=nil)
      base_power * length_up_pct(color) * plus_up_pct(color)
    end

    # 強化ドロップによる加算倍率
    def plus_up_pct(color=nil)
      1 + (plus_count(color) * DROP_PLUS_UP_BASE)
    end

    # 強化ドロップの数
    def plus_count(color=nil)
      return 0 unless color
      case @data[:plus_drop]
      when Numeric
        0
      when Hash
        return 0 unless @data[:plus_drop][color]
        @data[:plus_drop][color]
      else
        0
      end
    end

    # 繋げた長さによる加算倍率
    def length_up_pct(color=nil)
      combo_count(color) + (length_count(color) * LENGTH_UP_BASE)
    end

    # 繋げた長さ（余剰分）
    def length_count(color=nil)
      return 0 unless color
      case @data[:combo]
      when Numeric
        0
      when Hash
        return 0 unless @data[:combo][color]
        length_count_sub(@data[:combo][color])
      else
        0
      end
    end

    # 配列内の 3 以上の余剰分の数を返す
    def length_count_sub(count_data)
      count_data.inject(0) do |val, i| val += i - 3 end
    end

  end
end
