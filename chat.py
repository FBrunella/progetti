import streamlit as st
from streamlit_chat import message
from langchain_ollama import OllamaLLM
from neo4j import GraphDatabase
import re

# Inizializza il modello 
llm = OllamaLLM(model="deepseek-r1:8b")

# Configura la connessione a Neo4j
NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASSWORD = "awesome_prin"

driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASSWORD))

# Funzione per eseguire una query Cypher
def run_cypher_query(query):
    try:
        with driver.session() as session:
            result = session.run(query)
            return [record.data() for record in result]
    except Exception as e:
        return [{"error": str(e)}]

# Funzione per estrarre una query Cypher da un blocco ```cypher

def extract_cypher_query(text):
    match = re.search(r"```cypher\s*([\s\S]+?)\s*```", text, re.IGNORECASE)
    if match:
        return match.group(1).strip()
    return None

# Configura la UI della chat
st.set_page_config(layout="wide")
st.title("🤖 Chatbot con Mistral, LangChain e Neo4j")

# Inizializza la sessione per la chat
if "messages" not in st.session_state:
    st.session_state.messages = []

# Inizializza il comportamento predefinito in inglese 
# aggiungi un inserisci schema sotto il comportamento la layout
DEFAULT_BEHAVIOR = """Sei un assistente AI esperto in database Neo4j. Il tuo compito è capire la richiesta dell'utente, scrivere solo query Cypher
corrette per Neo4j, eseguirle e mostrare i risultati. Non usare SQL, non spiegare SQL, non tradurre in SQL 
Rispondi in modo tecnico e diretto con codice Cypher. Il database Neo4j a cui fai riferimento è caratterizzato dal seguente schema:


CREATE CONSTRAINT ON (c:COLLECTION) ASSERT c.collection_id IS NOT NULL;
CREATE CONSTRAINT ON (ca:CATEGORY) ASSERT ca.category_id IS NOT NULL;
CREATE CONSTRAINT ON (t:TRANSACTION) ASSERT t.transaction_id IS NOT NULL;
CREATE CONSTRAINT ON (w:WALLET) ASSERT w.wallet_id IS NOT NULL;
CREATE CONSTRAINT ON (n:NFT) ASSERT n.token_key IS NOT NULL;

// Esempi di nodi
CREATE (c:COLLECTION {collection: '...', collection_id: '...'});
CREATE (ca:CATEGORY {category: '...', category_id: '...'});
CREATE (t:TRANSACTION {
    transaction_hash: '...',
    crypto: '...',
    transaction_date: datetime('...'),
    price: 0.0,
    price_usd: 0.0,
    transaction_id: '...'
});
CREATE (w:WALLET {address: '...', wallet_id: '...', username: '...'});
CREATE (n:NFT {
    token_id: '...',
    image_url1: '...',
    image_url2: '...',
    image_url3: '...',
    image_url4: '...',
    permanent_link: '...',
    name: '...',
    description: '...',
    token_key: '...'
});

// Creazione delle relazioni

// Un wallet compra una transazione
MATCH (w:WALLET), (t:TRANSACTION)
CREATE (w)-[:BUY]->(t);

// Un wallet vende una transazione
MATCH (w:WALLET), (t:TRANSACTION)
CREATE (w)-[:SELL]->(t);

// Un NFT appartiene a una categoria
MATCH (n:NFT), (ca:CATEGORY)
CREATE (n)-[:IN_CAT]->(ca);

// Un NFT appartiene a una collezione
MATCH (n:NFT), (c:COLLECTION)
CREATE (n)-[:IN_COLL]->(c);

// Una transazione è associata a un NFT
MATCH (t:TRANSACTION), (n:NFT)
CREATE (t)-[:TRANS_FOR_NFT]->(n);

"""

if "behavior" not in st.session_state:
    st.session_state.behavior = DEFAULT_BEHAVIOR

if "show_behavior_settings" not in st.session_state:
    st.session_state.show_behavior_settings = False

# Sidebar
with st.sidebar:
    if st.button("⚙️ Modifica comportamento"):
        st.session_state.show_behavior_settings = not st.session_state.show_behavior_settings

    if st.session_state.show_behavior_settings:
        st.subheader("🔧 Personalizza il comportamento")
        behavior_input = st.text_area("Descrivi il comportamento dell'IA:", "", height=100)

        if st.button("Salva"):
            st.session_state.behavior = behavior_input if behavior_input.strip() else DEFAULT_BEHAVIOR
            st.session_state.show_behavior_settings = False
            st.success("✅ Comportamento aggiornato!")

# Mostra la chat esistente
for i, msg in enumerate(st.session_state.messages):
    is_user = msg["role"] == "user"
    message(msg["content"], is_user=is_user, key=str(i))

    if not is_user:
        query_cypher = extract_cypher_query(msg["content"])
        if query_cypher:
            with st.container():
                st.code(query_cypher, language="cypher")
                if st.button(f"▶️ Esegui Cypher {i}", key=f"run_cypher_{i}"):
                    result = run_cypher_query(query_cypher)
                    st.subheader("📆 Risultato:")
                    st.json(result)

# Form per inviare i messaggi
with st.form(key="chat_form", clear_on_submit=True):
    user_input = st.text_input("Scrivi un messaggio:", key="user_input")
    submit_button = st.form_submit_button("Invia")

if submit_button and user_input:
    st.session_state.messages.append({"role": "user", "content": user_input})

    prompt = f"{st.session_state.behavior}\n\nUtente: {user_input}\nRispondi in base alle istruzioni sopra."

    risposta = llm.invoke(prompt)

    st.session_state.messages.append({"role": "ai", "content": risposta})

    st.rerun()
