aws-doc-pdf-download
====================

##️ Usage

### run

```sh
npm install -g phantomjs
bundle install --path=vendor/bundle
bundle exec ruby ./scraping.rb
```

### dockernize 

```sh
docker build -t your_name/image_name .
docker run --rm -v $HOME/path/to:/app your_name/image_name
```

## configuration

- configs.yml

```yaml
output:
  ja_doc: "./output/ja_jp_matome/"
  whitepaper: "./output/whitepaper_matome/"
urls:
  computing:
    - "http://aws.amazon.com/jp/documentation/ec2/"
    - "http://aws.amazon.com/jp/documentation/ecr/"

(snip)
```
