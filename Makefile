# Use by calling: url=<url>
url=$1

run:
	python app/web_scraping.py $(url) | xsel --clipboard --input
