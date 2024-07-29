from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import sys

if len(sys.argv) != 2:
    print('Fallo en la ejecución. Debe ingresar un dominio a buscar.')
    sys.exit(1)

busqueda = sys.argv[1]

# Inicializa el navegador sin abrir una ventana
options = webdriver.ChromeOptions()
options.add_argument('headless')
driver = webdriver.Chrome(options=options)
driver = webdriver.Chrome()

# do not open a window


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
    print(html)

finally:
    # Cierra el navegador
    driver.quit()
