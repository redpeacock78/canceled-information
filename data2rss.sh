#!/usr/bin/env bash


###PARAMETER###
TMP_DATA="$(mktemp)"

###FUNCTION###
cat ./data.txt | while read LINE; do
echo -e "        <item>\n            <title>${LINE}</title>\n            <link>https://www.kyoto-art.ac.jp/student/</link>\n            <description><![CDATA[休講情報 | 京都造形芸術大学 在学生専用サイト]]></description>\n            <pubData>$(LANG="C" date -d $(echo ${LINE} | tail -n1 | awk '{print $1}') "+%a,%m %b %Y %H:%M:%S %z JST")</pubData>\n        </item>"
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
