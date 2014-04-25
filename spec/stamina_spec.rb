# -*- coding: utf-8 -*-

require 'spec_helper'
require 'pazzdra'

describe Pazzdra::Stamina, "スタミナ回復時間計算機能" do
  context 'インスタンスで使用する場合' do
    before do
      @stamina = Pazzdra::Stamina.new
    end

    context '基本機能' do
      it "回復時刻を知る" do
        time_format(@stamina.stamina(6)).should eq time_format(Time.now + (60 * 60))
      end
      it "指定時刻でのスタミナ数" do
        @stamina.stamina(time_format(Time.now + (60 * 60 * 1))).should eq 5
      end
    end
  end
end

