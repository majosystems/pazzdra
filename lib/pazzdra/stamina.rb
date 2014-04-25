# -*- coding: utf-8 -*-

require 'time'

module Pazzdra
  class Stamina
    class << Stamina
      def cal(target_time=nil, base_stamina=0)
        target_time ||= Time.now + (60 * 60 * 8)
        (base_stamina + (target_time - Time.now) / 60 / 10).to_i
      end
      def cal_time(target_stamina, base_stamina=0)
        Time.now + (60 * 10 * (target_stamina - base_stamina))
      end
    end

    attr_accessor :target_time
    attr_accessor :base_stamina

    def initialize
      @target_time = Time.now + (60 * 60 * 8)
      @base_stamina = 0
    end

    def stamina(val=nil)
      case val
      when Numeric, NilClass
        stamina_time val
      when String
        stamina_val val
      end
    end

    def stamina_time(val=0)
      Stamina.cal_time val, @base_stamina
    end

    def stamina_val(val)
      Stamina.cal Time.parse(val), @base_stamina
    end
  end
end
