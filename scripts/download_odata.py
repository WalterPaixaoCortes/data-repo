import requests
import pandas as pd
import time

# === CONFIGURAÇÕES ===
base_url = "https://sol.simbacal.com/AcumaticaERP/odata/BI - WRP Rebuild"
username = "WCortes"
password = "Python2025@"
page_size = 100
output_csv = "wrp_rebuild.csv"

# === AUTENTICAÇÃO ===
auth = (username, password)  # Basic Auth

# === LISTA PARA ACUMULAR OS DADOS ===
all_rows = []
page = 0

while True:
    skip = page * page_size
    url = f"{base_url}?$top={page_size}&$skip={skip}"

    print(f"🔄 Baixando página {page + 1}...")

    response = requests.get(url, auth=auth, headers={"Accept": "application/json"})

    if response.status_code != 200:
        print(f"❌ Erro ao acessar {url}")
        print(response.status_code, response.text)
        break

    data = response.json()

    # Se o resultado for vazio, parar a paginação
    if "value" not in data or not data["value"]:
        print("✅ Fim da paginação. Nenhum dado novo.")
        break

    # Adiciona ao acumulador
    all_rows.extend(data["value"])
    page += 1

    # Intervalo opcional entre chamadas
    time.sleep(0.1)

# === SALVAR EM CSV ===
if all_rows:
    df = pd.DataFrame(all_rows)
    df.to_csv(output_csv, index=False, encoding="utf-8-sig")
    print(f"✅ Dados salvos em {output_csv} com {len(df)} linhas.")
else:
    print("⚠️ Nenhum dado encontrado.")
