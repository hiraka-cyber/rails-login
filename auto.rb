require 'selenium-webdriver'

def high_low_purchase(driver, wait, high_low_xxx, entry_price)
    if high_low_xxx == "high"
      puts "Highを選択, エントリープライスは #{entry_price}円"
      driver.find_element(:xpath, "//input[@class='number-only eng first-child last-child']").clear # 金額を数値を消す 
      driver.find_element(:xpath, "//input[@class='number-only eng first-child last-child']").send_keys(entry_price) # 金額を入力
      driver.find_element(:xpath, "//div[text()='High']").click
      driver.find_element(:xpath, "//a[text()='今すぐ購入']").click
    elsif high_low_xxx == "low"
      puts "Lowを選択, エントリープライスは #{entry_price}円"
      driver.find_element(:xpath, "//input[@class='number-only eng first-child last-child']").clear # 金額を数値を消す
      driver.find_element(:xpath, "//input[@class='number-only eng first-child last-child']").send_keys(entry_price) # 金額を入力 
      driver.find_element(:xpath, "//div[text()='Low']").click
      driver.find_element(:xpath, "//a[text()='今すぐ購入']").click
    end
end



def scraping
  url = 'https://trade.highlow.com/' #デモ
  driver = Selenium::WebDriver.for :chrome# ブラウザ起動
  wait = Selenium::WebDriver::Wait.new(timeout: 10000)
  driver.navigate.to url
  puts "サイトにアクセス開始"
  driver.manage.timeouts.implicit_wait = 1000
  puts "======スクレイピング開始======#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}======"
  puts "デモクリック"
  wait.until { driver.find_element(:xpath, "//a[@class='highlight hidden-xs outlineNone']").displayed? } #要素の確認
  driver.find_element(:xpath, "//a[@class='highlight hidden-xs outlineNone']").click #demoをクリック
  puts "取引を始めるをクリック"
  wait.until { driver.find_element(:xpath, "//a[@class='exit-onboarding btn btn-default btn-extruded last-child']").displayed? } #要素の確認
  driver.find_element(:xpath, "//a[@class='exit-onboarding btn btn-default btn-extruded last-child']").click#取引を始めるのクリック
  puts "Turboタグをクリック"
  sleep(1)
  wait.until { driver.find_element(:xpath, "//*[@id='assetsGameTypeZoneRegion']/ul/li[3]").displayed? }
  driver.find_element(:xpath, "//*[@id='assetsGameTypeZoneRegion']/ul/li[3]").click #turboのタブをクリック
  puts "1分足をクリック"
  wait.until { driver.find_element(:xpath, "//*[@id='assetsCategoryFilterZoneRegion']/div/div[3]").displayed? }
  driver.find_element(:xpath, "//*[@id='assetsCategoryFilterZoneRegion']/div/div[3]").click#1分足のタブをクリック


  puts "全ての資産タブをクリック"
  wait.until { driver.find_element(:xpath, "//div[@id='highlow-asset-filter']").displayed? }
  driver.find_element(:xpath, "//div[@id='highlow-asset-filter']").click#全ての資産タブを選択
  puts "GBP/JPYの通貨ペアを入力して選択"
  wait.until { driver.find_element(:xpath, "//*[@id='searchBox']").displayed? }
  driver.find_element(:xpath, "//*[@id='searchBox']").send_keys("GBP/JPY")
  wait.until { driver.find_element(:xpath, "//*[@id='assetsFilteredList']/div").displayed? }
  driver.find_element(:xpath, "//*[@id='assetsFilteredList']/div").click
  
  martin = 1 #初期のマーチン設定

  loop do #取引を常に行う
    #残高確認
    wait.until { driver.find_element(:xpath, "//span[@class='balance-display balanceValue balanceArea last-child loaded']").displayed? }
    zandaka1 = driver.find_element(:xpath, "//span[@class='balance-display balanceValue balanceArea last-child loaded']").text
    zandaka2 = driver.find_element(:xpath, "//span[@class='cashback-balance balance-display last-child']").text
    if zandaka2.empty?
      zandaka_x = zandaka1.delete("¥").delete(",").to_i
    else
      zandaka_x = zandaka1.delete("¥").delete(",").to_i + zandaka2.delete("¥").delete(",").to_i
    end
    
    driver.execute_script("window.scrollTo(0, 400);")
    high_low_xxx = ["high", "low"].sample
    
    # エントリー金額の設定
    if martin == 1
      entry_price = 1000
    elsif martin >= 129 #8回以上のマーチンは20万円のエントリー金額を超えるのでまた1000円からやり直し 
      entry_price = 1000
    else
      entry_price = 1000 * martin
    end 

    high_low_purchase(driver, wait, high_low_xxx, entry_price) # エントリー
    sleep(80) #エントリー結果の確認待ち時間

    #残高確認
    zandaka1 = driver.find_element(:xpath, "//span[@class='balance-display balanceValue balanceArea last-child loaded']").text
    zandaka2 = driver.find_element(:xpath, "//span[@class='cashback-balance balance-display last-child']").text
    if zandaka2.empty?
      puts "現在の口座残高 : " + zandaka1.to_s
      zandaka_y = zandaka1.delete("¥").delete(",").to_i
    else
      puts "現在の口座残高 : " + zandaka1.to_s + "  キャッシュバック金額 : " + zandaka2.to_s
      zandaka_y = zandaka1.delete("¥").delete(",").to_i + zandaka2.delete("¥").delete(",").to_i
    end

    #マーチン設定など
    if zandaka_x < zandaka_y
      martin = 1
      puts "勝ち!! うほー今夜は焼肉だ!!"
    elsif zandaka_x == zandaka_y #エントリー出来ていない場合は何もしない。
    else
      martin = martin * 2
      puts "負け くそー次はマーチンで倍掛けだ!!"
    end
  end

end # scraping end

scraping