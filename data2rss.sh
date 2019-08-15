#!/usr/bin/env bash


###PARAMETER###
TMP_DATA="$(mktemp)"

###FUNCTION###
cat ./data.txt | while read LINE; do
echo -e "        <item>\n            <title>$(echo ${LINE} | awk '{print $3}')</title>\n            <link>https://www.kyoto-art.ac.jp/student/</link>\n            <description>$(LANG="C" date -d $(echo ${LINE} | awk '{print $1}') "+%Y/%m/%d")</description>\n            <author>$(echo ${LINE} | awk '{print $2,$4}')</author>\n            <pubData>$(LANG="C" date "+%a, %d %b %Y %H:%M:%S %z")</pubData>\n        </item>"
done > "${TMP_DATA}"


###TEXT###
cat << RSS > ./out.xml
<?xml version='1.0' encoding='UTF-8'?>
<rss version='2.0'>
    <channel>
        <title>京都造形芸術大学:休講情報</title>
        <link>https://www.kyoto-art.ac.jp/student/</link>
        <description><![CDATA[休講情報 | 京都造形芸術大学 在学生専用サイト]]></description>
$(cat "${TMP_DATA}")
    </channel>
</rss>
RSS

rm -rf "${TMP_DATA}"
