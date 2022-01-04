from django.shortcuts import render
import requests
from bs4 import BeautifulSoup as b
# Create your views here.
def index(request):
    return render(request, 'index.html')

def search(request):
    if request.method == 'POST':
        search = request.POST['search']
        url = 'https://www.ask.com/web?q='+search
        res = requests.get(url)
        soup = b(res.text, 'lxml')

        lresult = soup.find_all('div', {'class': 'PartialSearchResults-item'})

        fresult = []

        for result in lresult:
            result_title = result.find(class_='PartialSearchResults-item-title').text
            result_url = result.find('a').get('href')
            result_desc = result.find(class_='PartialSearchResults-item-abstract').text

            fresult.append((result_title, result_url, result_desc))

        context = {
            'fresult': fresult
        }

        return render(request, 'search.html', context)

    else:
        return render(request, 'search.html')