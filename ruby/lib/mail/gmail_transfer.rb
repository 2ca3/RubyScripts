require "mail"
require "FileUtils"

options = { :address  => "smtp.gmail.com",
            :port     => 587,
            :domain   => "smtp.gmail.com",
            :user_name => "foo@gmail.com",
            :password  => "password",
            :authentication       => :plain,
            :enable_starttls_auto => true  }
mail = Mail.new
mail.charset = "utf-8"
mail.from = "foo@gmail.com"
mail.subject = "ファイルサーバ変更のお知らせ"
mail.delivery_method(:smtp, options)
body = File.read("body.txt", :encoding => Encoding::UTF_8)
open("users.csv") do |file|
  while line = file.gets
    columns = line.chomp.split(",")
    // 文字列を置換してbodyへ
	mail.body = body.gsub("name",columns[2]).gsub("id",columns[0]).gsub("pw",columns[1]) 
    // 送信先を設定
	mail.to = columns[2]    
    mail.deliver
    // メールサーバへの急激な負荷増大を考えて適当にsleep
	sleep(1)
  end
end
