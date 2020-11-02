require 'sqlite3'
require 'csv'

def summertime(csv_time)
  csv_time = Time.parse(csv_time)
  @time_x = 25200 # 冬時間
  if Time.parse("2005.3.13") <= csv_time && csv_time <= Time.parse("2005.11.6")    
    @time_x = 21600 # 夏時間
  elsif Time.parse("2006.3.12") <= csv_time && csv_time <= Time.parse("2006.11.5") 
    @time_x = 21600
  elsif Time.parse("2007.3.11") <= csv_time && csv_time <= Time.parse("2007.11.4")
      @time_x = 21600
  elsif Time.parse("2008.3.9")  <= csv_time && csv_time <= Time.parse("2008.11.2")
      @time_x = 21600
  elsif Time.parse("2009.3.8")  <= csv_time && csv_time <= Time.parse("2009.11.1")
      @time_x = 21600
  elsif Time.parse("2010.3.14") <= csv_time && csv_time <= Time.parse("2010.11.7")
      @time_x = 21600
  elsif Time.parse("2011.3.13") <= csv_time && csv_time <= Time.parse("2011.11.6")
      @time_x = 21600
  elsif Time.parse("2012.3.11") <= csv_time && csv_time <= Time.parse("2012.11.4")
      @time_x = 21600
  elsif Time.parse("2013.3.10") <= csv_time && csv_time <= Time.parse("2013.11.3")
      @time_x = 21600
  elsif Time.parse("2014.3.9")  <= csv_time && csv_time <= Time.parse("2014.11.2")
      @time_x = 21600
  elsif Time.parse("2015.3.8")  <= csv_time && csv_time <= Time.parse("2015.11.1")
      @time_x = 21600
  elsif Time.parse("2016.3.13") <= csv_time && csv_time <= Time.parse("2016.11.6")
      @time_x = 21600
  elsif Time.parse("2017.3.12") <= csv_time && csv_time <= Time.parse("2017.11.5")
      @time_x = 21600
  elsif Time.parse("2018.3.11") <= csv_time && csv_time <= Time.parse("2018.11.4")
      @time_x = 21600
  elsif Time.parse("2019.3.10") <= csv_time && csv_time <= Time.parse("2019.11.3")
      @time_x = 21600
  elsif Time.parse("2020.3.8")  <= csv_time && csv_time <= Time.parse("2020.11.1")
      @time_x = 21600
  elsif Time.parse("2021.3.14") <= csv_time && csv_time <= Time.parse("2021.11.7")
      @time_x = 21600
  elsif Time.parse("2022.3.13") <= csv_time && csv_time <= Time.parse("2022.11.6")
      @time_x = 21600
  elsif Time.parse("2023.3.12") <= csv_time && csv_time <= Time.parse("2023.11.5")
      @time_x = 21600
  elsif Time.parse("2024.3.10") <= csv_time && csv_time <= Time.parse("2024.11.3")
      @time_x = 21600
  elsif Time.parse("2025.3.9")  <= csv_time && csv_time <= Time.parse("2025.11.2")
      @time_x = 21600
  elsif Time.parse("2026.3.8")  <= csv_time && csv_time <= Time.parse("2026.11.1")
      @time_x = 21600
  elsif Time.parse("2027.3.14") <= csv_time && csv_time <= Time.parse("2027.11.7")
      @time_x = 21600
  elsif Time.parse("2028.3.12") <= csv_time && csv_time <= Time.parse("2028.11.5")
      @time_x = 21600
  elsif Time.parse("2029.3.11") <= csv_time && csv_time <= Time.parse("2029.11.4")
      @time_x = 21600
  elsif Time.parse("2030.3.10") <= csv_time && csv_time <= Time.parse("2030.11.3")
      @time_x = 21600
  elsif Time.parse("2031.3.9")  <= csv_time && csv_time <= Time.parse("2031.11.2")
      @time_x = 21600
  elsif Time.parse("2032.3.14") <= csv_time && csv_time <= Time.parse("2032.11.7")
      @time_x = 21600
  elsif Time.parse("2033.3.13") <= csv_time && csv_time <= Time.parse("2033.11.6")
      @time_x = 21600
  elsif Time.parse("2034.3.12") <= csv_time && csv_time <= Time.parse("2034.11.5")
      @time_x = 21600
  elsif Time.parse("2035.3.11") <= csv_time && csv_time <= Time.parse("2035.11.4")
      @time_x = 21600
  elsif Time.parse("2036.3.9")  <= csv_time && csv_time <= Time.parse("2036.11.2")
      @time_x = 21600
  elsif Time.parse("2037.3.8")  <= csv_time && csv_time <= Time.parse("2037.11.1")
      @time_x = 21600
  elsif Time.parse("2038.3.14") <= csv_time && csv_time <= Time.parse("2038.11.7")
      @time_x = 21600
  end
end #summertime end


def writing

  db = SQLite3::Database.new 'usdjpy5m.db'
  csv_file_name = "tmusdjpy_backtest.csv"
  csv = csv_file_name
  new_data = []
  CSV.foreach(csv).each_with_index do |row, i|
    array = []
    if row[2] == "lower" #lowエントリー
      puts "*****************************"
      sql_select = "select * from historical_data where date = '#{row[0]}' and time = '#{row[1]}'"
      p arrow_time = db.execute(sql_select.to_s)[0]
      entry_time =    arrow_time[0].to_i + 1 #エントリー足
      sql_select = "select * from historical_data where id = '#{entry_time}'"
      p entry_time = db.execute(sql_select.to_s)[0]
      judgment_time = arrow_time[0].to_i + 2 #判定足
      sql_select = "select * from historical_data where id = '#{judgment_time}'"
      p judgment_time = db.execute(sql_select.to_s)[0]

      s_time = row[0] + " " + row[1]
      summertime(s_time) # 夏時間検証
      ttt = Time.parse(s_time) + @time_x
      array << ttt.strftime("%Y/%m/%d")
      array << ttt.strftime("%H:%M:%S")
      array << "low"
      if entry_time[3] > judgment_time[6]
        puts "win"
        array << "win"
      else
        puts "lose"
        array << "lose"
      end
      new_data << array

    elsif row[2] == "upper" #highエントリー
      puts "*****************************"
      sql_select = "select * from historical_data where date = '#{row[0]}' and time = '#{row[1]}'"
      p arrow_time = db.execute(sql_select.to_s)[0]
      entry_time =    arrow_time[0].to_i + 1 #エントリー足
      sql_select = "select * from historical_data where id = '#{entry_time}'"
      p entry_time = db.execute(sql_select.to_s)[0]
      judgment_time = arrow_time[0].to_i + 2 #判定足
      sql_select = "select * from historical_data where id = '#{judgment_time}'"
      p judgment_time = db.execute(sql_select.to_s)[0]
      s_time = row[0] + " " + row[1]
      summertime(s_time) # 夏時間検証
      ttt = Time.parse(s_time) + @time_x
      array << ttt.strftime("%Y/%m/%d")
      array << ttt.strftime("%H:%M:%S")
      array << "high"
      if entry_time[3] < judgment_time[6]
        puts "win"
        array << "win"
      else
        puts "lose"
        array << "lose"
      end
      new_data << array

    end
  end
  db.close
  # p new_data
  CSV.open("tm_biynary_refined.csv","wb") do |csv| #精製したデータの書き込み処理
    new_data.each do |csvArray|
      csv << csvArray
    end
  end

end

writing