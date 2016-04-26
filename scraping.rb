# -*- encoding: utf-8 -*-
require "open-uri"
require "nokogiri"
require "uri"
require "fileutils"
require "capybara"
require "capybara/poltergeist"
require "pp"
require "yaml"

class SFDocDownload

    def initialize(configs)
      @output_ja_doc = configs["output"]["ja_doc"]
      @output_whitepaper = configs["output"]["whitepaper"]
      @urls = configs["urls"]
    end

    # 出力先のディレクトリ作成
    def mkdir_output
        begin
            Dir.mkdir("output")
            FileUtils.mkdir_p(@output_ja_doc)
            FileUtils.mkdir_p(@output_whitepaper)
        rescue Exception => e
        end
    end

    def init_scrape
        @write_dir = ""

        #poltergistの設定
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 }) #追加のオプションはググってくださいw
        end
        Capybara.default_selector = :xpath

        @session = Capybara::Session.new(:poltergeist)
        
        # ヘッダ
        @session.driver.headers = {'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)"} 
        # cookie
        @session.driver.set_cookie('aws-doc-lang', 'ja_jp')
    end

    def run
        # 初期化
        mkdir_output
        init_scrape

        # 対象URL
        @urls.each do |sb, parse_urls|
            @write_dir = "./output/" + sb.to_s + "/"

            begin
                FileUtils.mkdir_p(@write_dir)
            rescue Exception => e
            end

            # URLからHTMLを抽出
            parse_urls.each do |parse_url|
                self.start_parse(parse_url)
            end
        end
    end

    def start_parse(parse_url, rcv_count = 0)
        # 再帰処理制御
        if rcv_count >= 2
            return
        end

        if parse_url =~ /.*docs.aws.amazon.com.*/
            if !(parse_url =~ /.*ja_jp.*/)
                parse_url = parse_url.sub(/docs.aws.amazon.com/, 'docs.aws.amazon.com/ja_jp')
            end
        end

        if parse_url =~ /.*\/quickstart\/latest\/sitecore\/.*/
            parse_url = "http://docs.aws.amazon.com/ja_jp/quickstart/latest/sitecore/"
        end

        # htmlを取得する
        # html = ""
        # charset = nil
        # begin
        #     html = open(parse_url) do |file|
        #       charset = file.charset
        #       file.read
        #     end
        # rescue Exception => e
        #     return
        # end

        # htmlをパース
        # p "parse:" + parse_url
        @session.visit parse_url
        doc = Nokogiri::HTML.parse(@session.html)

        # uriをパース
        uri = URI.parse(@session.current_url)

        # <a>タグを拾う
        doc.css('a').each do |e|
            # hrefを取得し、PDFチェック
            url = e[:href]
            if !url
                next
            end

            # pp e
            # pp e.attributes
            # pp e.children

            if e.children.to_s == 'PDF'
                # puts parse_url
                # puts url
            end

            if url =~ /https:\/\/aws.amazon.com\/\?nc.*/
                next
            end
            if url =~ /https:\/\/aws.amazon.com\/(jp|de|es|fr|it|pt|ru|ko|cn|tw)\/\?nc.*/
                next
            end

            filename = self.get_filename_from_url(url)
            if filename =~ /latest/i || url =~ /latest/i
            end

            if url.match(/(http|https).*\.pdf$/)
                # このまま
            elsif url.match(/\/\/.*\.pdf$/)
                url = uri.scheme + ":" + url
            elsif url.match(/.*\.pdf$/)
                url = uri.scheme + "://" + uri.host + uri.path.match(/.*\//).to_s + url
            elsif url.match(/javascript/)
                next
            elsif e.children.to_s == 'HTML'
                self.start_parse(url, rcv_count + 1)
                next
            else
                next
            end

            # store file
            store_file(url)
       end
    end

    def store_file(url)
        # PDFの保存
        filename = self.get_filename_from_url(url)
        if !File.exist?(@write_dir + filename)
            begin
                open(@write_dir + filename, 'wb') do |file|
                    p url
                    f = OpenURI.open_uri(url, {:proxy=>nil})
                    file.write(f.read) #ファイル名で保存
                end
            rescue 
                p "error:" + url
            end
        end

        # 日本語系をまとめる
        if filename =~ /(ja|jp)/i || url =~ /\/(ja|jp)\//i
            FileUtils.cp(@write_dir + filename, "output/ja_jp_matome/" + filename, {:noop => false})
        end
        # WhitePaper系をまとめる
        if filename =~ /(wp|whitepaper)/i
            FileUtils.cp(@write_dir + filename, "output/whitepaper_matome/" + filename, {:noop => false})
        end
    end

    def get_filename_from_url(url)
        return File.basename(URI.unescape(url))
    end
end

configs = YAML.load(File.read("configs.yml"))
ddl = SFDocDownload.new(configs)
ddl.run
