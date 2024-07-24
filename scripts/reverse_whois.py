from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

busqueda = input("Introduce la empresa a buscar: ")

# Inicializa el navegador
driver = webdriver.Chrome()

try:
    # Navega a la página web
    driver.get(f'https://viewdns.info/reversewhois/?q={busqueda}')

    # Espera a que la tabla sea visible, ajustando el tiempo de espera si es necesario
    WebDriverWait(driver, 100).until(
        EC.presence_of_element_located((By.TAG_NAME, 'table'))
    )

    # Duerme por unos segundos para asegurar que la página cargue completamente (ajustar si es necesario)
    time.sleep(1)

    # Imprime el HTML completo de la página
    html = driver.page_source
    with open(f'{busqueda}.html', 'w') as f:
        f.write(html)
    print('HTML guardado con éxito')
    with open('temp_nombre', 'w') as f:
        f.write(busqueda)

finally:
    # Cierra el navegador
    driver.quit()
