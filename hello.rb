// 出力系
puts 'hello'
print 'hello'

//変数
massage = 'Hello world'
//変数を出力するときはクォーテーション、ダブルクォーテーションはいらないよ。
puts message

//あんま使わないけど演算系
hensu_one = 15 + 15　//足し算
hesu_two = 15 + 10　//引き算
hensu_three = 15 * 23　//掛け算
hensu_four = 40 / 10　//割り算
hensu_five = 10 % 3　//あまり
//まとめて出力しちゃいます。
puts(hensu_one, hesu_two, hensu_three, hensu_four, hensu_five)

//四捨五入
puts 52.6.round
puts 52.6.floor
puts 52.6.ceil

//これもあんま使わない配列系と思いきや、実はめっちゃ使っている
list_number = [1,2,3,4,5,6,7,8,9]

puts list_numbers[1]
puts list_numbers[0..2]

list_numbers.push('10') //リストの末尾に追加

//hash objects 3パターン書き方があります。
hash_ob = {'one'=>200, 'two'=>300}
hash_ob = {:one=>200, :two=>300}
hash_ob = {one: 200, two: 300}
puts hash_ob[:one]

//array
array_ob = ['one','two','three']
puts arrat_ob[1]


//if文　条件分岐 rubyは最後にendがいります！
jyoken_one = 10
jyoken_two = '10'

if jyoken_one == jyoken_two.to_i
   puts 'true!'
else
   puts 'false!'
end

//あんま使わないけど
to_iは文字列を整数値に変換します。
to_fは文字列を浮動小数点に変換します。
to_sは数字を文字列に変換します。
to_hはArrayをHashに変換します。
to_aはHashをArrayに変換します。

//条件が複数ある場合、a = true ではないが b = trueの時など
a = 10
b = '10'
if a == '10'
   puts 'false'
elif a == 10
   puts 'true!'
elif b == 10
   puts 'false'
elif b == '10'
   puts 'true!'
end

//case で条件分岐 if分のほうがよくつかわれます。
color = 'red'

case color
when 'red' then
  puts 'result'
when 'green' then
  puts 'no..'
when 'yello' then
  puts 'no..'
else
  puts 'wrong color'
end

//ループ処理 繰り返し行いたい処理　これはマジでよく出てきます。
//まずはあんま使わないほうのwhile ループ 3回繰り返す

i = 0
while i < 3 do
   puts "#{i} hey!"
   i += 1
end

//よく出るtimes method ループ 3回繰り返す

3.times do |i|
    if i == 1
      break　//この場合は繰り返さず条件が満たしたら終了
    end
    puts "#{i} hey!"
end

3.times do |i|
    if i == 1
      next //この場合は条件を満たすときスキップをします。同じ処理をしたいけど、ある条件では処理したくない場合に使うよ。
    end
    puts "#{i} hey!"
end

//pythonでよく使うfor文 railsではあまりつかない印象です。作りたいものによるけど..

for i in 1..5 do //1～５の数字が変数iに代入されputsで繰り返した数だけiに入っている数字が出力されるよく使うのはarrayの中身を一個ずつ出すときにiに配列を一つずつ代入して出力します。
    puts i
end

//配列を出力する
for color in ['blue','pink','violet']//まさにこんな感じです。配列を一つずつ変数colorに代入して,出力します。
    puts color
end

//ということはhashもいける
for name, color in{'apple':'red','banana':'yellow'}
   puts "#{name}:#{color}"
end

//これもマジでよく出るeach methodループ処理
colors = ['red','blue','yellow']

colors.each do |c| //colorsに入っている配列をcという変数に代入して一つずつ出力します。
   puts "color:#{c}"
end

//pythonでよく使うループはこっち
colors = ['red','blue','yellow']
for color in colors //colorsリストをcolorに代入して出力しします。
   puts 'color:"{color}"
end

//関数これはほんとにどこでも出る。rubyの場合は最後にendがいります。
def hello(name) //def に続いて関数名を指定する()内には引数をいれる欲しい情報がかえって来るように使います
    puts "Hello,#{name}!"　//今回はnameという引数に名前をいれると関数が実行されたら挨拶するような関数となっています。
end

hello('takasi')　//作成した関数を呼び出すには関数名を記述して（）内に引数を指定します。今回は名前をが欲しいので適当に名前をいれます。

//クラスこれはガチでめっちゃ出てきます。ここの理解があるかないかだけでもかなりの理解のスピードも変わってきます！

class User　//クラスは一連の動作をまとめたようなもので,関数やら変数やらを多用して情報をまとめて渡したり、取得したりするプログラミングで非常に重要な部分となっています。

 def initialize(name) //インスタンスといって新規作成、投稿するときなどに必ず実行される関数です。
     @name = name
 end

 def Hello //先ほど同様に挨拶をするような関数を作成しています。
     puts "Hey! My name is #{@name}"
 end

end

//クラスを使って新たにUserを作成して、挨拶を返してみます。

yamada = User.new('yamada') //これでUserが新たに作成されます
yamada.Hello //Hello関数を実行します。

基本的にはこの応用がruby on railsという感じですね。

ruby on railsではcontroller , model, viewとありましてcontrollerの部分がまさに関数、クラスを多用します。
migrationというのもありますが、こちらはデータベースといって多用するのはhashやarrayの部分ですね。
作成されたデータはarray,hashのようにリストで保存されていきます。
データベースに保存された、データをviewでtimes method やeach methodのループ処理で繰り返し出力していくと
SNSのような投稿、コメント、ログインしているユーザー、ユーザーごとの投稿を出力しているわけですね！
さて基本構文はこんなもんです！