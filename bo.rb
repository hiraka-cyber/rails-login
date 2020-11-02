require 'sqlite3'
require 'csv'


def usdjpy5m_sqlite
  puts "DB制作開始"
  db = SQLite3::Database.new 'usdjpy5m.db'
  
  puts "テーブル作成"
  # create table
  sql = <<-SQL
    create table historical_data (
      id integer primary key,
      date text,
      time text,
      open text,
      high text,
      low text,
      colse text,
      volume text
    );
  SQL
  
  if db.execute("SELECT tbl_name FROM sqlite_master WHERE type == 'table'").flatten.include?("historical_data") == true
      puts "テーブルはすでにあるので書き込み開始"
  else
      db.execute(sql)
  end

  csv_file_name = "EURAUD5.csv"
  csv = "C:/Users/royzg/Desktop/pydemo/Documents/anv1/fx/" + csv_file_name
  puts "書き込み開始"
  CSV.foreach(csv).each_with_index do |row, i|
    db.execute("insert into historical_data (date, time, open, high, low, colse, volume) values ('#{row[0].to_s}', '#{row[1].to_s}', '#{row[2].to_s}', '#{row[3].to_s}', '#{row[4].to_s}', '#{row[5].to_s}', '#{row[6].to_s}')")
  end
  puts "書き込み完了"

  db.close

end

usdjpy5m_sqlite
