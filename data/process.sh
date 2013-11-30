# to get the raw data:

mkdir -p /tmp/cra/
cd /tmp/cra

wget -rkpN -l1 http://cra.org/ads/P0/
wget -rkpN -l1 http://cra.org/ads/P100/
wget -rkpN -l1 http://cra.org/ads/P200/

# extract txts from htmls 
find .  -name "*.html" -exec sh -c 'html2text {} > {}.txt'  \;

# optional: cut header and footer from the txts...
# banner lines ..
HEADER=109
FOOTER=10

#tail -n +110 index.html.txt | head -n -10
#find .  -name "*.txt" -exec sh -c 'tail -n +109 {} | head -n -10 > {}.short && mv {}.short {}'  \;

find .  -name "*.txt" -exec sh -c 'tail -n +110 {} | head -n -10 > {}.short'  \;
