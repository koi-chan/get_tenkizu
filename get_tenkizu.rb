#!/usr/bin/ruby

require 'date'
require 'open-uri'

# 取得元のURLと拡張子
URL = {
  mono: 'http://www.jma.go.jp/jp/g3/images/jp/'
  color: 'http://www.jma.go.jp/jp/g3/images/jp_c/'
}
FILE_EXT = '.png'

# 取得する日付
target_date = (Date.today - 1).strftime('%y%m%d')

# 保存先のディレクトリパス
SAVE_DIR = ''




if Dir.exist?(SAVE_DIR)
  Dir.chdir(SAVE_DIR)
else
  raise "Error: #{SAVE_DIR} は存在しません"
end

%w(03 06 09 12 15 18 21).each do |hour|
  URL.each do |type, url|
    filename = "#{target_date}#{hour}_#{type}#{FILE_EXT}"
    open("#{url}#{target_date}#{hour}#{FILE_EXT}") do |file|
      open(filename, 'w+b') do |out|
        out.write(file.read)
      end
    end
  end
end
