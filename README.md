# Lorenzo Agnolucci

# Elaborato IA
Disposizione di oggetti con la forma dei pezzi del Tetris su una scacchiera

Per scegliere i valori di input si deve modificare il file Dati_input.dzn. Per eseguire Modello.mzn ci si deve assicurare che si trovi nella stessa cartella di Dati_input.dzn.

Si deve usare il solver Gecode 6.1.0 [built-in], preferibilmente con i seguenti parametri (modificabili con il configuration editor
all'interno di Minizinc IDE):

-number of threads = 10,   per migliorare le prestazioni e diminuire il tempo di risoluzione

-output timing information = flagged,  per visualizzare il tempo di risoluzione
