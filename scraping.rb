# -*- encoding: utf-8 -*-
#################################################
# 
# 
# 
# 
# 
#################################################
require "open-uri"
require "nokogiri"
require "uri"

# URL
urls = ["http://aws.amazon.com/jp/documentation/ec2/", 
        "http://aws.amazon.com/jp/documentation/autoscaling/", 
        "http://aws.amazon.com/jp/documentation/elasticloadbalancing/",
        "http://aws.amazon.com/jp/documentation/vpc/",
        "http://aws.amazon.com/jp/documentation/route53/",
        "http://aws.amazon.com/jp/documentation/directconnect/",
        "http://aws.amazon.com/jp/documentation/lambda/",

        "http://aws.amazon.com/jp/documentation/cloudformation/",
        "http://aws.amazon.com/jp/documentation/cloudtrail/",
        "http://aws.amazon.com/jp/documentation/config/",
        "http://aws.amazon.com/jp/documentation/cloudwatch/",
        "http://aws.amazon.com/jp/documentation/codedeploy/",
        "http://aws.amazon.com/jp/documentation/directory-service/",
        "http://aws.amazon.com/jp/documentation/elasticbeanstalk/",
        "http://aws.amazon.com/jp/documentation/iam/",
        "http://aws.amazon.com/jp/documentation/kms/",
        "http://aws.amazon.com/jp/documentation/opsworks/",
        "http://aws.amazon.com/jp/documentation/cloudhsm/",

        "http://docs.aws.amazon.com/gettingstarted/latest/awsgsg-intro/gsg-aws-intro.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/computebasics-linux/web-app-hosting-intro.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/computebasics/web-app-hosting-intro.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/wah-linux/web-app-hosting-intro.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/wah/web-app-hosting-intro.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/deploy/welcome.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/emr/getting-started-emr-overview.html",
        "http://docs.aws.amazon.com/gettingstarted/latest/swh/website-hosting-intro.html",

        "http://aws.amazon.com/jp/documentation/s3/", 
        "http://aws.amazon.com/jp/documentation/glacier/", 
        "http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html", 
        "http://aws.amazon.com/jp/documentation/importexport/", 
        "http://aws.amazon.com/jp/documentation/storagegateway/", 
        "http://aws.amazon.com/jp/documentation/cloudfront/", 

        "http://aws.amazon.com/jp/documentation/appstream/", 
        "http://aws.amazon.com/jp/documentation/cloudsearch/", 
        "http://aws.amazon.com/jp/documentation/elastictranscoder/", 
        "http://aws.amazon.com/jp/documentation/ses/", 
        "http://aws.amazon.com/jp/documentation/sqs/", 
        "http://aws.amazon.com/jp/documentation/swf/", 

        "http://docs.aws.amazon.com/awsconsolehelpdocs/latest/gsg/getting-started.html", 
        "http://aws.amazon.com/jp/documentation/sdkforjava/", 
        "http://aws.amazon.com/jp/documentation/sdkforjavascript/", 
        "http://aws.amazon.com/jp/documentation/sdkfornet/", 
        "http://aws.amazon.com/jp/documentation/sdkforphp/", 
        "http://boto.readthedocs.org/en/latest/", 
        "http://aws.amazon.com/jp/documentation/sdkforruby/", 
        "http://aws.amazon.com/jp/documentation/awstoolkiteclipse/", 
        "http://aws.amazon.com/jp/documentation/awstoolkitvisualstudio/", 
        "http://aws.amazon.com/jp/documentation/cli/", 
        "http://aws.amazon.com/jp/documentation/powershell/", 

        "http://aws.amazon.com/jp/documentation/elasticmapreduce/", 
        "http://aws.amazon.com/jp/documentation/kinesis/", 
        "http://aws.amazon.com/jp/documentation/datapipeline/", 

        "http://aws.amazon.com/jp/documentation/workspaces/", 
        "http://aws.amazon.com/jp/documentation/zocalo/", 

        "http://aws.amazon.com/jp/documentation/cognito/", 
        "http://aws.amazon.com/jp/documentation/mobileanalytics/", 
        "http://aws.amazon.com/jp/documentation/sns/", 
        "http://aws.amazon.com/jp/documentation/sdkforandroid/", 
        "http://aws.amazon.com/jp/documentation/sdkforios/", 

        "http://aws.amazon.com/jp/documentation/accountbilling/", 
        "http://aws.amazon.com/jp/documentation/marketplace/", 
        "http://aws.amazon.com/jp/documentation/awssupport/", 
        "http://docs.aws.amazon.com/general/latest/gr/glos-chap.html", 

        "http://aws.amazon.com/jp/documentation/alexatopsites/", 
        "http://aws.amazon.com/jp/documentation/awis/", 
        "http://aws.amazon.com/jp/documentation/mturk/", 
        "http://aws.amazon.com/jp/documentation/silk/", 
        "http://docs.aws.amazon.com/govcloud-us/latest/UserGuide/welcome.html", 

        "http://aws.amazon.com/jp/whitepapers/", 
        "http://aws.amazon.com/jp/aws-jp-introduction/index.html"]

# 出力先のディレクトリ作成
begin
    Dir.mkdir("output")
rescue Exception => e
    
end

# 対象URL
urls.each do |parse_url|

    # URLからHTMLを抽出
    html = ""
	charset = nil
	html = open(parse_url) do |file|
	  charset = file.charset
	  file.read
	end

	# htmlをパース
    doc = Nokogiri::HTML.parse(html, nil, charset) rescue next

    # <a>タグを拾う
    doc.css('a').each do |e|
        # hrefを取得し、PDFチェック
        url = e[:href]
        if !url
            next
        end
        if !url.match(/http.*\.pdf$/)
            next
        end

        # PDFの保存
        filename = File.basename(URI.unescape(url))
        begin
            open("output/" + filename, 'wb') do |file|
                f = OpenURI.open_uri(url, {:proxy=>nil})
                file.write(f.read) #ファイル名で保存
            end
        rescue 
            p url
            next
        end
    end
end
