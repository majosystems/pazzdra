# Pazzdra

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pazzdra'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pazzdra

## Usage

このgemはパズドラの攻撃力を計算する計算機です。

インストールすると pad_cal コマンドが使えるようになります。

    $ pad_cal

このコマンドは引数として数値を複数取れますが、その場合は単に数値を掛け合わせたものを表示するだけの簡単な計算機です。

引数を指定せずに実行すると対話形式で計算ができます。

 > help!

で使えるコマンドが出ますので、試してみてください。

## 使用例

    $ pad_calc
      pazzdra calc ver.0.0.1
        > help!
    [1] pry(Pazzdra)> base_1 r: 1200, sub: :g  # 1人目の攻撃力 火属性 1200, 副属性は木で登録
    => {:r=>1200, :sub=>:g}
    [2] pry(Pazzdra)> base_2 g: 880, sub: :y  # 2人目の攻撃力 火属性 880, 副属性は木で登録
    => {:g=>880, :sub=>:y}
    [3] pry(Pazzdra)> combo_red [3,3] # コンボ赤は 3個が2つ
    => [3, 3]
    [4] pry(Pazzdra)> combo_green [4] # コンボ緑は 4個が1つ
    => [4]
    [5] pry(Pazzdra)> combo_purple [3,3] # コンボ紫は 3個が2つ
    => [3, 3]
    [6] pry(Pazzdra)> show # 結果を表示しろ
    {:base=>[{:r=>1200, :sub=>:g}, {:g=>880, :sub=>:y}], :leader=>1, :friend=>nil, :skill=>nil, :up_drops=>nil, :combo=>{:r=>[3, 3], :g=>[4], :p=>[3, 3]}}
    [{:r=>4800, :sub=>{:g=>1500}}, {:g=>2200, :sub=>{:y=>0}}]
    => [{:r=>4800, :sub=>{:g=>1500}}, {:g=>2200, :sub=>{:y=>0}}]  # 計算結果
    [7] pry(Pazzdra)>


## Contributing

1. Fork it ( http://github.com/<my-github-username>/pazzdra/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
