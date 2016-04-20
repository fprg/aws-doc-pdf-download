# -*- encoding: utf-8 -*-
#################################################
# 
# 
# 
# 
# http://aws.amazon.com/jp/documentation/
#################################################
require "open-uri"
require "nokogiri"
require "uri"
require "fileutils"
require "capybara"
require "capybara/poltergeist"
require "pp"


# URL
# urls = ["http://aws.amazon.com/jp/documentation/ec2/", 
#         "http://aws.amazon.com/jp/documentation/autoscaling/", 
#         "http://aws.amazon.com/jp/documentation/elasticloadbalancing/",
#         "http://aws.amazon.com/jp/documentation/vpc/",
#         "http://aws.amazon.com/jp/documentation/route53/",
#         "http://aws.amazon.com/jp/documentation/directconnect/",
#         "http://aws.amazon.com/jp/documentation/lambda/",

#         "http://aws.amazon.com/jp/documentation/cloudformation/",
#         "http://aws.amazon.com/jp/documentation/cloudtrail/",
#         "http://aws.amazon.com/jp/documentation/config/",
#         "http://aws.amazon.com/jp/documentation/cloudwatch/",
#         "http://aws.amazon.com/jp/documentation/codedeploy/",
#         "http://aws.amazon.com/jp/documentation/directory-service/",
#         "http://aws.amazon.com/jp/documentation/elasticbeanstalk/",
#         "http://aws.amazon.com/jp/documentation/iam/",
#         "http://aws.amazon.com/jp/documentation/kms/",
#         "http://aws.amazon.com/jp/documentation/opsworks/",
#         "http://aws.amazon.com/jp/documentation/cloudhsm/",

#         "http://docs.aws.amazon.com/gettingstarted/latest/awsgsg-intro/gsg-aws-intro.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/computebasics-linux/web-app-hosting-intro.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/computebasics/web-app-hosting-intro.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/wah-linux/web-app-hosting-intro.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/wah/web-app-hosting-intro.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/deploy/welcome.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/emr/getting-started-emr-overview.html",
#         "http://docs.aws.amazon.com/gettingstarted/latest/swh/website-hosting-intro.html",

#         "http://aws.amazon.com/jp/documentation/s3/", 
#         "http://aws.amazon.com/jp/documentation/glacier/", 
#         "http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html", 
#         "http://aws.amazon.com/jp/documentation/importexport/", 
#         "http://aws.amazon.com/jp/documentation/storagegateway/", 
#         "http://aws.amazon.com/jp/documentation/cloudfront/", 

#         "http://aws.amazon.com/jp/documentation/appstream/", 
#         "http://aws.amazon.com/jp/documentation/cloudsearch/", 
#         "http://aws.amazon.com/jp/documentation/elastictranscoder/", 
#         "http://aws.amazon.com/jp/documentation/ses/", 
#         "http://aws.amazon.com/jp/documentation/sqs/", 
#         "http://aws.amazon.com/jp/documentation/swf/", 

#         "http://docs.aws.amazon.com/awsconsolehelpdocs/latest/gsg/getting-started.html", 
#         "http://aws.amazon.com/jp/documentation/sdkforjava/", 
#         "http://aws.amazon.com/jp/documentation/sdkforjavascript/", 
#         "http://aws.amazon.com/jp/documentation/sdkfornet/", 
#         "http://aws.amazon.com/jp/documentation/sdkforphp/", 
#         "http://boto.readthedocs.org/en/latest/", 
#         "http://aws.amazon.com/jp/documentation/sdkforruby/", 
#         "http://aws.amazon.com/jp/documentation/awstoolkiteclipse/", 
#         "http://aws.amazon.com/jp/documentation/awstoolkitvisualstudio/", 
#         "http://aws.amazon.com/jp/documentation/cli/", 
#         "http://aws.amazon.com/jp/documentation/powershell/", 

#         "http://aws.amazon.com/jp/documentation/elasticmapreduce/", 
#         "http://aws.amazon.com/jp/documentation/kinesis/", 
#         "http://aws.amazon.com/jp/documentation/datapipeline/", 

#         "http://aws.amazon.com/jp/documentation/workspaces/", 
#         "http://aws.amazon.com/jp/documentation/zocalo/", 

#         "http://aws.amazon.com/jp/documentation/cognito/", 
#         "http://aws.amazon.com/jp/documentation/mobileanalytics/", 
#         "http://aws.amazon.com/jp/documentation/sns/", 
#         "http://aws.amazon.com/jp/documentation/sdkforandroid/", 
#         "http://aws.amazon.com/jp/documentation/sdkforios/", 

#         "http://aws.amazon.com/jp/documentation/accountbilling/", 
#         "http://aws.amazon.com/jp/documentation/marketplace/", 
#         "http://aws.amazon.com/jp/documentation/awssupport/", 
#         "http://docs.aws.amazon.com/general/latest/gr/glos-chap.html", 

#         "http://aws.amazon.com/jp/documentation/alexatopsites/", 
#         "http://aws.amazon.com/jp/documentation/awis/", 
#         "http://aws.amazon.com/jp/documentation/mturk/", 
#         "http://aws.amazon.com/jp/documentation/silk/", 
#         "http://docs.aws.amazon.com/govcloud-us/latest/UserGuide/welcome.html", 

        # "http://aws.amazon.com/training/architect/", 
        # "http://aws.amazon.com/architecture/", 

#         "http://aws.amazon.com/jp/whitepapers/", 
#         "http://aws.amazon.com/jp/aws-jp-introduction/index.html"]

# https://aws.amazon.com/jp/documentation/

urls = {
    :computing => [
        "http://aws.amazon.com/jp/documentation/ec2/",
        "http://aws.amazon.com/jp/documentation/ecs/",
        "http://aws.amazon.com/jp/documentation/elastic-beanstalk/",
        "http://aws.amazon.com/jp/documentation/lambda/", 
        "http://aws.amazon.com/jp/documentation/autoscaling/", 
        "http://aws.amazon.com/jp/documentation/elasticloadbalancing/", 
        "http://aws.amazon.com/jp/documentation/vpc/"
    ], 
    :managment => [
        "http://aws.amazon.com/jp/documentation/cloudwatch/", 
        "http://aws.amazon.com/jp/documentation/cloudformation/", 
        "http://aws.amazon.com/jp/documentation/cloudtrail/", 
        "http://aws.amazon.com/jp/documentation/cli/", 
        "http://aws.amazon.com/jp/documentation/config/", 
        "http://docs.aws.amazon.com/awsconsolehelpdocs/latest/gsg/getting-started.html", 
        "http://aws.amazon.com/jp/documentation/opsworks/", 
        "http://aws.amazon.com/jp/documentation/servicecatalog/"
    ], 
    :networking => [
        "http://aws.amazon.com/jp/documentation/vpc/", 
        "http://aws.amazon.com/jp/documentation/direct-connect/", 
        "http://aws.amazon.com/jp/documentation/elastic-load-balancing/", 
        "http://aws.amazon.com/jp/documentation/route53/"
    ], 
    :storage_and_contents_deliver => [
        "http://aws.amazon.com/jp/documentation/s3/",
        "http://aws.amazon.com/jp/documentation/cloudfront/",
        "http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html", 
        "http://aws.amazon.com/jp/documentation/efs/", 
        "http://aws.amazon.com/jp/documentation/glacier/", 
        "http://aws.amazon.com/jp/documentation/importexport/", 
        "http://aws.amazon.com/jp/documentation/storage-gateway/"
    ], 
    :enterprise_application => [
        "http://aws.amazon.com/jp/documentation/workspaces/", 
        "http://aws.amazon.com/jp/documentation/wam/", 
        "http://aws.amazon.com/jp/documentation/workdocs/", 
        "http://aws.amazon.com/jp/documentation/workmail/"
    ],
    :developer_tool => [
        "http://aws.amazon.com/jp/documentation/codecommit/", 
        "http://aws.amazon.com/jp/documentation/codedeploy/", 
        "http://aws.amazon.com/jp/documentation/codepipeline/", 
        "http://aws.amazon.com/jp/documentation/cli/"
    ],
    :resource => [
        "http://aws.amazon.com/jp/documentation/accountbilling/", 
        "http://aws.amazon.com/jp/documentation/marketplace/", 
#        "http://aws.amazon.com/jp/documentation/quickstart/", 
        "http://aws.amazon.com/jp/documentation/awssupport/", 
        "http://docs.aws.amazon.com/general/latest/gr/", 
        "http://docs.aws.amazon.com/general/latest/gr/glos-chap.html"
    ], 
    :security_and_id => [
        "http://aws.amazon.com/jp/documentation/iam/", 
        "http://aws.amazon.com/jp/documentation/directory-service/", 
        "http://aws.amazon.com/jp/documentation/inspector/", 
        "http://aws.amazon.com/jp/documentation/cloudhsm/", 
        "http://aws.amazon.com/jp/documentation/kms/", 
        "http://aws.amazon.com/jp/documentation/waf/", 
        "http://aws.amazon.com/jp/documentation/aws-support/"
    ], 
    :database => [
        "http://aws.amazon.com/jp/documentation/rds/", 
        "http://aws.amazon.com/jp/documentation/SchemaConversionTool/", 
        "http://aws.amazon.com/jp/documentation/dynamodb/", 
        "http://aws.amazon.com/jp/documentation/elasticache/", 
        "http://aws.amazon.com/jp/documentation/redshift/"
    ], 
    :analytics => [
        "http://aws.amazon.com/jp/documentation/elasticmapreduce/", 
        "http://aws.amazon.com/jp/documentation/data-pipeline/", 
        "http://aws.amazon.com/jp/documentation/elasticsearch-service/", 
        "http://aws.amazon.com/jp/documentation/kinesis/", 
        "http://aws.amazon.com/jp/documentation/firehose/", 
        "http://aws.amazon.com/jp/documentation/machine-learning/", 
        "http://aws.amazon.com/jp/documentation/redshift/"
    ], 
    :iot => [
        "http://aws.amazon.com/jp/documentation/iot/"
    ], 
    :mobile_service => [
        "http://aws.amazon.com/jp/documentation/mobile-hub/", 
        "http://aws.amazon.com/jp/documentation/apigateway/", 
        "http://aws.amazon.com/jp/documentation/cognito/", 
        "http://aws.amazon.com/jp/documentation/devicefarm/", 
        "http://aws.amazon.com/jp/documentation/mobileanalytics/", 

        "http://aws.amazon.com/jp/documentation/sdk-for-android/", 
        "http://aws.amazon.com/jp/documentation/sdk-for-ios/", 
        "http://aws.amazon.com/jp/documentation/sdk-for-unity/", 

        "http://aws.amazon.com/jp/documentation/sns/"
    ], 
    :application_service => [
        "http://aws.amazon.com/jp/documentation/apigateway/", 
        "http://aws.amazon.com/jp/documentation/appstream/", 
        "http://aws.amazon.com/jp/documentation/cloudsearch/", 
        "http://aws.amazon.com/jp/documentation/elastictranscoder/", 
#        "http://aws.amazon.com/jp/documentation/fps/", 
        "http://aws.amazon.com/jp/documentation/ses/", 
        "http://aws.amazon.com/jp/documentation/sns/", 
        "http://aws.amazon.com/jp/documentation/sqs/", 
        "http://aws.amazon.com/jp/documentation/swf/"
    ], 
    :relation_link => [
        "http://aws.amazon.com/jp/whitepapers/", 
        "http://aws.amazon.com/jp/training/", 
        "http://aws.amazon.com/jp/solutions/case-studies/", 
        "http://aws.amazon.com/jp/documentation/kindle/", 
        "http://aws.amazon.com/archives"
    ], 
    :additional_software_and_service => [
        "http://aws.amazon.com/jp/documentation/alexatopsites/", 
        "http://aws.amazon.com/jp/documentation/awis/", 
        "http://aws.amazon.com/jp/documentation/silk/", 
        "http://docs.aws.amazon.com/govcloud-us/latest/UserGuide/welcome.html"
    ], 
    :other => [
        "http://aws.amazon.com/jp/documentation/aws-support/", 
        "http://aws.amazon.com/jp/documentation/gettingstarted/", 
        "https://aws.amazon.com/tools/", 
        "http://aws.amazon.com/documentation/kindle", 
        "http://docs.aws.amazon.com/general/latest/gr/Welcome.html", 
        "http://aws.amazon.com/jp/training/", 

        "http://aws.amazon.com/jp/whitepapers/"
    ], 
    :architecture => [
        "http://aws.amazon.com/training/architect/", 
        "http://aws.amazon.com/architecture/"
    ], 
    :security => [
        "http://aws.amazon.com/jp/security/"
    ], 
    :aws_seminar => [
        "https://aws.amazon.com/jp/aws-jp-introduction/"
    ], 
    :certification_asa => [
        "https://aws.amazon.com/jp/certification/certified-solutions-architect-associate/"
    ], 
    :certification_psa => [
        "https://aws.amazon.com/jp/certification/certified-solutions-architect-professional/"
    ], 
    :certification_adev => [
        "https://aws.amazon.com/jp/certification/certified-developer-associate/"
    ], 
    :certification_aso => [
        "https://aws.amazon.com/jp/certification/certified-sysops-admin-associate/"
    ], 
    :certification_pdoe => [
        "https://aws.amazon.com/jp/certification/certified-devops-engineer-professional/"
    ], 
}

class SFDocDownload

    # 出力先のディレクトリ作成
    def mkdir_output
        begin
            Dir.mkdir("output")
            FileUtils.mkdir_p("./output/ja_jp_matome/")
            FileUtils.mkdir_p("./output/whitepaper_matome/")
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

    def run(urls)
        # 初期化
        self.mkdir_output
        self.init_scrape

        # 対象URL
        urls.each do |sb, parse_urls|
            @write_dir = "./output/" + sb.to_s + "/"
            puts @write_dir

            begin
                FileUtils.mkdir_p(@write_dir)
            rescue Exception => e
            end

            # URLからHTMLを抽出
            parse_urls.each do |parse_url|
                # puts parse_url
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

        # uriをパース
        uri = URI.parse(parse_url)

        # htmlをパース
        # doc = Nokogiri::HTML.parse(html, nil, charset) rescue return
        @session.visit parse_url
        doc = Nokogiri::HTML.parse(@session.html)
        if rcv_count >= 1
            # puts html
        end

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
        #puts @write_dir + filename
        if !File.exist?(@write_dir + filename)
            begin
                open(@write_dir + filename, 'wb') do |file|
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

ddl = SFDocDownload.new
ddl.run urls
