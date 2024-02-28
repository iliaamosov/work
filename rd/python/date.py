# скрипт для парсинга дат библиотек из mvn. для СБ. подготовить txt файл с url, изменить конфиги, запустить

import requests
from bs4 import BeautifulSoup
import time
import re

def check_url_exists_and_get_release_date(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT   10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    try:
        response = requests.get(url, headers=headers)
        if response.status_code ==   200:
            soup = BeautifulSoup(response.text, 'html.parser')
            # Ищем элемент <td> с датой релиза
            date_element = soup.find('td', string=re.compile(r'\b\w{3} \d{2}, \d{4}\b'))
            if date_element:
                release_date = date_element.string.strip()
                print(f"{url} exists. Release date: {release_date}")
                return release_date
            else:
                print(f"{url} exists, but release date not found.")
        else:
            print(f"{url} does not exist or is not accessible.")
    except requests.exceptions.RequestException as e:
        print(f"Error checking {url}: {e}")

def process_urls_from_file_and_save_dates(file_path, results_file):
    with open(file_path, 'r') as file:
        urls = file.readlines()

    with open(results_file, 'a') as file:
        for url in urls:
            url = url.strip()  # Удаляем символы новой строки и пробелы
            release_date = check_url_exists_and_get_release_date(url)
            if release_date:
                file.write(f"{url}: {release_date}\n")
            time.sleep(1)  # Задержка в   1 секунду между запросами

# 'urls.txt' путь к  файлу с ссылками
#  'results.txt'  путь к файлу, куда будут записаны результаты
file_path = 'urls.txt'
results_file = 'results.txt'
process_urls_from_file_and_save_dates(file_path, results_file)
