aws-doc-pdf-download
====================

aws-doc-pdf-download

    curl -O http://aws.amazon.com/jp/aws-jp-introduction/index.html
    grep "pdf" ./index.html > index2.html
    sed -e "s/^.*pdf.+$//g" ./index2.html > index3.html
    sed -e "s/^.*href=\"//g" ./index3.html > index4.html
    sed -e "s/pdf\".*/pdf/g" ./index4.html > index5.html
    sed -e "s/^/curl -O /g" ./index5.html > index6.html
