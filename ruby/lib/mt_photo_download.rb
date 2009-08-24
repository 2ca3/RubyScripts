require "FileUtils"
require "open-uri"

puts "start"
filename = "D:/usr/local/foobar/post.txt" # MT形式のエクスポートファイルのパス。自分の環境に合わせる。
basedir = "D:/usr/local/foobar/photo/" # 画像の出力先のベースとなるディレクトリ。自分の環境に合わせる。
open(filename) do |file|
  while l = file.gets
    l.scan(/"(http:\/\/foo.blog.ocn.ne.jp\/foobar_blog\/\S*.JPG)"/i).flatten.each do |url| # 自分の環境に合わせる。
      dir = url.slice(38,url.rindex("/")-37) #index以降のディレクトのパスを取得。マジックナンバーがきもい。自分の環境に合わせる。
      if dir
        dir = basedir + dir
        FileUtils.mkdir_p(dir) unless File.exist?(dir)
      else
        dir = basedir
      end
      puts url
      filename = File.basename(url)
      open(dir + filename, 'wb') do |out|
        open(url) do |jpg|
          out.write(jpg.read)
        end
      end
    end
  end
end
puts "end"