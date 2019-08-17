#!/usr/bin/env bash
#---------------------------------------------------------------------------
# MeCabユーザ辞書の作り方（Wikipediaの題名を名詞とした）。
# CreatedAt: 2019-08-17
#---------------------------------------------------------------------------
# 元データ取得（日本語Wikipediaの全題名）
curl -L http://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz | gunzip > jawiki-latest-all-titles-in-ns0
# 元データ→MeCab用CSV
ruby makedic.rb
# MeCab用CSV→MeCabユーザ辞書
/usr/lib/mecab/mecab-dict-index \
-d /usr/share/mecab/dic/ipadic \
-u wikipedia_20190817.dic \
-f utf-8 \
-t utf-8 \
onomasticon.csv

# 使ってみる
echo "クラウド" | mecab
echo "クラウド" | mecab -u wikipedia_20190817.dic
echo "クラウド" | mecab --unk-feature "未知語"
echo "クラウド" | mecab -u wikipedia_20190817.dic --unk-feature "未知語"

# ツールなどのパスを検索する（環境ごとに違う）
find / -name "mecab-dict-index"
find / -name "dicrc"
find / -name "rewrite.def"
find / -name "mecabrc"

