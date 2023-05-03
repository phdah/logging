import requests
from bs4 import BeautifulSoup
import sys

# URL to scrape
url = sys.argv[1]

# Send a GET request to the URL
response = requests.get(url)

# Create a BeautifulSoup object from the response text
soup = BeautifulSoup(response.text, 'html.parser')

# Find all paragraph tags in the HTML
paragraphs = soup.find_all('p')

# Print out the text of each paragraph
print('''Summarize this in one short sentence, explain it like i'm a developer:
```
''')
for paragraph in paragraphs:
    print(paragraph.text)
print('```')
