
# analyticsrelationships

analyticsrelationships --url $domain > $current_search_folder/raw/analyticsrelationships.txt

# Gau

gau --threads 10 $domain > $current_search_folder/raw/gau.txt

# CTFR

ctfr -d $domain > $current_search_folder/raw/ctfr.txt

# CTFORG

ctfrorg -d $domain > $current_search_folder/raw/ctfrorg.txt

# Katana

echo $domain | katana -silent -jc -o $current_search_folder/raw/katana.txt -kf robotstxt,sitemapxml

# Amass

amass enum -d $domain -max-dns-queries 10 -o $current_search_folder/raw/amass.txt

# Cero

cero -d $domain -o $current_search_folder/raw/cero.txt
