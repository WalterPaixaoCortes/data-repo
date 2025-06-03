import requests
import xml.etree.ElementTree as ET

# ===== CONFIGURAÇÕES =====
ODATA_METADATA_URL = "https://<baseurl>/<service>/$metadata"  # Altere para sua URL real
ENTITY_NAME = (
    "<EntitySetName>"  # Nome da entidade principal, conforme aparece no metadata
)
TABLE_NAME = "<NomeTabelaDestino>"  # Nome da tabela que você quer criar


# ===== Função para mapear tipos OData para SQL Server =====
def odata_type_to_sql(edm_type):
    mapping = {
        "Edm.String": "NVARCHAR(MAX)",
        "Edm.Int32": "INT",
        "Edm.Int64": "BIGINT",
        "Edm.Int16": "SMALLINT",
        "Edm.Boolean": "BIT",
        "Edm.DateTimeOffset": "DATETIMEOFFSET",
        "Edm.DateTime": "DATETIME",
        "Edm.Decimal": "DECIMAL(18,2)",
        "Edm.Double": "FLOAT",
        "Edm.Single": "REAL",
        "Edm.Guid": "UNIQUEIDENTIFIER",
        # Adicione outros conforme necessário
    }
    return mapping.get(edm_type, "NVARCHAR(MAX)")


# ===== Baixa o metadata do OData =====
resp = requests.get(ODATA_METADATA_URL)
if not resp.ok:
    raise Exception("Erro ao baixar o $metadata: " + resp.text)
root = ET.fromstring(resp.content)

# ===== Parseia o EDMX e encontra a EntityType =====
ns = {
    "edmx": "http://schemas.microsoft.com/ado/2007/06/edmx",
    "edm": "http://schemas.microsoft.com/ado/2008/09/edm",
}

# Procura EntityType correspondente ao EntitySet informado
entity_type_name = None
for entity_set in root.findall(".//edm:EntityContainer/edm:EntitySet", ns):
    if entity_set.attrib.get("Name") == ENTITY_NAME:
        entity_type_name = entity_set.attrib.get("EntityType").split(".")[-1]
        break

if not entity_type_name:
    raise Exception(f"EntitySet '{ENTITY_NAME}' não encontrada no $metadata.")

entity_type = None
for et in root.findall(".//edm:EntityType", ns):
    if et.attrib.get("Name") == entity_type_name:
        entity_type = et
        break

if not entity_type:
    raise Exception(f"EntityType '{entity_type_name}' não encontrada no $metadata.")

# ===== Monta os campos SQL =====
columns = []
for prop in entity_type.findall("edm:Property", ns):
    col_name = prop.attrib["Name"]
    edm_type = prop.attrib["Type"]
    sql_type = odata_type_to_sql(edm_type)
    columns.append(f"    [{col_name}] {sql_type}")

# Define PK se houver (opcional)
pk = None
key = entity_type.find("edm:Key/edm:PropertyRef", ns)
if key is not None:
    pk = key.attrib["Name"]

sql = f"IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{TABLE_NAME}')\nBEGIN\n"
sql += f"CREATE TABLE [{TABLE_NAME}] (\n"
sql += ",\n".join(columns)
if pk:
    sql += f",\n    CONSTRAINT [PK_{TABLE_NAME}] PRIMARY KEY ([{pk}])"
sql += "\n)\nEND"

print(sql)
