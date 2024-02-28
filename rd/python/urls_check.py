import requests
import time

def check_url_exists(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT  10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    try:
        response = requests.get(url, headers=headers)
        if response.status_code ==   200:
            print(f"{url} exists.")
        else:
            print(f"{url} does not exist or is not accessible.")
    except requests.exceptions.RequestException as e:
        print(f"Error checking {url}: {e}")

def process_urls_from_file(file_path):
    with open(file_path, 'r') as file:
        urls = file.readlines()

    for url in urls:
        url = url.strip()  # Удаляем символы новой строки и пробелы
        check_url_exists(url)
        time.sleep(1)  # Задержка в   1 секунду между запросами

# Замените 'urls.txt' на путь к вашему файлу с ссылками
file_path = 'urls.txt'
results_file = 'results.txt'
process_urls_from_file(file_path)
