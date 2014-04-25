# -*- coding: utf-8 -*-

require 'spec_helper'
require 'pazzdra'

describe Pazzdra::Calc, "攻撃力計算機能" do
  context 'クラスから使用する場合' do
    it "基本の攻撃力のみ" do
      expect(Pazzdra::Calc.cal(1010)).to eq(1010)
    end

    it "リーダー x フレンド x エンハンス" do
      expect(Pazzdra::Calc.cal(1010,3.5)).to eq(3535)
      expect(Pazzdra::Calc.cal(810,2.5,3.5)).to eq(7088)
      expect(Pazzdra::Calc.cal(1234,2.5,2,1.5)).to eq(9255)
    end

    it "ドロップ追加" do
      expect(Pazzdra::Calc.cal(1010,3.5,3.5)).to eq(12373)
    end
  end

  context 'インスタンスで使用する場合' do
    before do
      @calc = Pazzdra::Calc.new
    end

    subject{ @calc.cal }
    context '基本！' do
      it "リーダーのみ" do
        @calc.merge({ base: 1000, leader: 1.5 })
        should eq 1500
      end
      it "リーダー x フレンド x エンハンス" do
        @calc.merge({ base: 1000, leader: 1.5, friend: 2, skill: 3.5 })
        should eq 10500
      end
    end
    context 'コンボデータ有' do
      it "ベースの色無し、コンボ数指定" do
        @calc.merge({ base: 1000, leader: 2.5, combo: 3 })
        should eq 3750
      end
      it "ベースの色無し、コンボ色指定" do
        @calc.merge({ base: 1000, leader: 2.5, combo: {r: [3], g: [3,4,4], b: [3] } })
        should eq 5000
      end
      it "ベースの色指定、コンボ色指定" do
        @calc.merge({ base: [{r: 1000}], leader: 2.5, combo: {r: [3], g: [3,4,4], b: [3] } })
        should eq [{r: 5000}]
      end
      it "ベースの色指定、コンボ色指定 複数" do
        @calc.merge({ base: [{r: 1000, sub: :r},{b: 1200, sub: :r}], leader: 2.5, combo: {r: [3], g: [3,4,4], b: [3] } })
        should eq [{r: 5000, sub: {r: 2500}},{b: 6000, sub: {r: 3000}}]
      end
      it "ベースの色指定、コンボ色指定 攻撃色が複数" do
        @calc.merge({ base: [{r: 1000}], leader: 2.5, combo: {r: [3, 3], g: [3,4], b: [3] } })
        should eq [{r: 10000}]
      end
      it "ベースの色指定、コンボ色指定 攻撃色が複数、長さ4越え" do
        @calc.merge({ base: [{g: 1200, sub: :g}], leader: 2.5, combo: {r: [3, 3], g: [3,4], b: [3] } })
        should eq [{g: 13500, sub: {g: 6750}}]
      end
      it "ベースの色指定、コンボ色指定 攻撃色が複数、長さ4越え 複数" do
        @calc.merge({ base: [{g: 1200, sub: :g},{y: 1234, sub: :r}], leader: 2.5, friend: 2, skill: 1.5, combo: {r: [3, 3], g: [3,4], b: [3], y: [4, 6] } })
        should eq [{g: 50625, sub: {g: 25313}},{y: 69413, sub: {r: 23138}}]
      end
      it "ベースの色指定、コンボ色指定 攻撃色が複数、長さ4越え 複数、強化ドロップあり" do
        @calc.merge({ base: [{g: 1200, sub: :g},{y: 1234, sub: :r}], leader: 2.5, friend: 2, skill: 1.5, combo: {r: [3, 3], g: [3,4], b: [3], y: [4, 6] }, plus_drop: {g: 4} })
        should eq [{g: 62775, sub: {g: 31388}},{y: 69413, sub: {r: 23138}}]
      end
    end
  end
end

