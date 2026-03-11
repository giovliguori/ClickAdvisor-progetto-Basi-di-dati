import pandas as pd

def convert_yelp_json_to_csv(input_json, output_csv):
    print(f"Caricamento e pulizia di {input_json}...")
    
    # Caricamento a blocchi per gestire file di grandi dimensioni
    chunks = pd.read_json(input_json, lines=True, chunksize=10000)
    
    first_chunk = True
    for df in chunks:
        # 1. Rimozione record con review_id o stars vuoti (NaN o stringhe vuote)
        # Il dataset Yelp definisce review_id come stringa di 22 caratteri
        df = df.dropna(subset=['review_id', 'stars'])
        df = df[df['review_id'].astype(str).str.strip() != '']

        # 2. Pulizia e Troncamento del testo (max 3000 caratteri)
        if 'text' in df.columns:
            # Rimuoviamo i ritorni a capo per evitare di spezzare le righe nel CSV/SQL
            df['text'] = df['text'].str.replace(r'[\n\r]+', ' ', regex=True)
            # Tronca a 3000 caratteri
            df['text'] = df['text'].str.slice(0, 3000)
            
        # 3. Validazione specifica degli ID (deve essere di 22 caratteri)
        # Questo evita che testi malformati vengano letti come ID lunghi
        df = df[df['review_id'].str.len() == 22]

        # 4. Conversione tipi per coerenza con lo schema SQL
        df['stars'] = df['stars'].astype(int)
        for col in ['useful', 'funny', 'cool']:
            if col in df.columns:
                df[col] = df[col].fillna(0).astype(int)

        # Scrittura su CSV con quoting protettivo
        df.to_csv(output_csv, 
                  mode='a', 
                  index=False, 
                  header=first_chunk, 
                  sep=',', 
                  encoding='utf-8',
                  quoting=1) # 1 = csv.QUOTE_ALL
        
        first_chunk = False
        print(f"Processate {len(df)} righe valide...")

    print(f"Conversione completata! File salvato come: {output_csv}")

# Esecuzione
convert_yelp_json_to_csv('review.json', 'recensioni_finali.csv')