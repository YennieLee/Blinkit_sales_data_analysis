import pandas as pd
import csv

# -------------------------
# 1. Clean Products file
# -------------------------
products = pd.read_csv('../datasets/blinkit_products.csv', encoding='utf-8')

def clean(s):
    if not isinstance(s, str): return s
    s = s.replace('–','-').replace('—','-').replace('“','"').replace('”','"').replace('’',"'")
    return s

products = products.applymap(clean)

products['address'] = products['address'].str.replace('\n', ' ')
products['address'] = products['address'].str.replace('\r\n', ' ')
products['address'] = products['address'].str.replace('"', ' ')

products.to_csv(
    '../datasets/blinkit_products_cleaned.csv',
    index=False,
    encoding='utf-8',
    lineterminator='\n', 
    quoting=csv.QUOTE_MINIMAL, 
    quotechar='"',
    doublequote=True
)


# -------------------------
# 2. Clean Customers file
# -------------------------
customer = pd.read_csv('../datasets/blinkit_customers.csv', encoding='utf-8')

def clean(s):
    if not isinstance(s, str): return s
    s = s.replace('–','-').replace('—','-').replace('“','"').replace('”','"').replace('’',"'")
    return s

customer = customer.applymap(clean)

customer['address'] = customer['address'].str.replace('\n', ' ')
customer['address'] = customer['address'].str.replace('\r\n', ' ')
customer['address'] = customer['address'].str.replace('"', ' ')

customer.to_csv(
    '../datasets/blinkit_customers_cleaned.csv',
    index=False,
    encoding='utf-8',
    lineterminator='\n',
    quoting=csv.QUOTE_MINIMAL, 
    quotechar='"',
    doublequote=True
)


# -------------------------
# 3. Clean Inventory file
# -------------------------
inventory = pd.read_csv('../datasets/blinkit_inventory.csv', dtype={'product_id': str})
inventory['date'] = pd.to_datetime(inventory['date'], dayfirst=True).dt.strftime('%Y-%m-%d')
inventory.to_csv('../datasets/blinkit_inventory_cleaned.csv', index=False, encoding='utf-8')