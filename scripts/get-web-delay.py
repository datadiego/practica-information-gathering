from playwright.sync_api import sync_playwright

def run(playwright):
    browser = playwright.chromium.launch(headless=True)  # Set headless to False to see what happens
    context = browser.new_context(
        user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    )
    page = context.new_page()
    page.goto('https://viewdns.info/reversewhois/?q=mercadona.es')
    page.wait_for_timeout(10000)  # Increment the timeout if necessary
    content = page.content()
    print(content)
    browser.close()

with sync_playwright() as playwright:
    run(playwright)
