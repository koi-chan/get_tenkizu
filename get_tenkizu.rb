#!/usr/bin/ruby

require 'date'
require 'open-uri'
require 'fileutils'

# 取得元のURLと拡張子
URL = {
  mono: 'http://www.jma.go.jp/jp/g3/images/jp/',
  color: 'http://www.jma.go.jp/jp/g3/images/jp_c/'
}
FILE_EXT = '.png'

# 取得する日付
target_date = (Date.today - 1).strftime('%y%m%d')

# 保存先のディレクトリパス
SAVE_DIR = ARGV[0]


begin
  Dir.chdir(SAVE_DIR)
  FileUtils.touch(target_date)
  FileUtils.rm(target_date)
rescue => e
  print("Error: #{e}\n")
  raise
end


%w(03 06 09 12 15 18 21).each do |hour|
  URL.each do |type, url|
    filename = "#{target_date}#{hour}_#{type}#{FILE_EXT}"
    print("#{filename} を取得中...\t")

    begin
      open("#{url}#{target_date}#{hour}#{FILE_EXT}") do |file|
        open(filename, 'w+b') do |out|
          out.write(file.read)
        end
      end
    rescue => e
      print("[ Failed ]\n")
      print("  #{e}\n")
      next
    end
    print("[ OK ]\n")
  end
end
