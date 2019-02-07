include "globals.mzn";    %per poter utilizzare count(array of var int, int)
include "Dati_input.dzn";

%input
int: n;
array[1..7] of int: k;

%verifica che input siano corretti
constraint assert(n >= 2, "Dimensione scacchiera non valida: n >= 2");
constraint assert(length(k) = 7, "Numero di pezzi non valido: length(k) = 7");


set of int: range = 1..n;    %range della scacchiera
set of int: blocks = 1..sum(k);    %numero totale di blocchi
array[blocks] of 1..7: block_type = [i | i in 1..7, j in 1.. k[i]];    %array composto da tutti i blocchi, associati alla propria forma 
%1->I, 2->J, 3->L, 4->O, 5->S, 6->T, 7->Z


array[range, range] of var 0..sum(k): board;    %scacchiera indicizzata a partire dall'angolo in alto a sinistra: X: riga, Y: colonna
array[blocks] of var range: posX;    %riga di una casella occupata da ciascun blocco  
array[blocks] of var range: posY;    %colonna di una casella occupata da ciascun blocco
array[blocks] of var 0..3: rotation;    %rotazione di 90° rispetto alla posizione standard: 0->0°, 1->90°, 2->180°, 3->270°


%Evita che si possa avere una somma delle caselle occupate dai blocchi maggiore delle caselle occupate dalla scacchiera
constraint sum(k)*4 <= n*n;


%Impone l'occupazione delle caselle della scacchiera in base al tipo e alla rotazione del blocco.
constraint forall(b in blocks)
(
    if block_type[b] == 1 then
      if rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b], posY[b]+2] = b /\ board[posX[b], posY[b]+3] = b
      elseif rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b]+1, posY[b]] = b /\ board[posX[b]+2, posY[b]] = b /\ board[posX[b]+3, posY[b]] = b
      else true endif
    elseif block_type[b] == 2 then
      if rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b]+1, posY[b]] = b /\ board[posX[b]+1, posY[b]+1] = b /\ board[posX[b]+1, posY[b]+2] = b
      elseif rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b]+1, posY[b]-1] = b /\ board[posX[b]+2, posY[b]-1] = b
      elseif rotation[b] == 2 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b]-1, posY[b]-1] = b /\ board[posX[b]-1, posY[b]-2] = b
      elseif rotation[b] == 3 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b]-1, posY[b]+1] = b /\ board[posX[b]-2, posY[b]+1] = b
      else true endif
    elseif block_type[b] == 3 then
      if rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b]-1, posY[b]+1] = b /\ board[posX[b]-1, posY[b]+2] = b
      elseif rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b]-1, posY[b]-1] = b /\ board[posX[b]-2, posY[b]-1] = b
      elseif rotation[b] == 2 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b]-1, posY[b]-1] = b /\ board[posX[b]-2, posY[b]-1] = b
      elseif rotation[b] == 3 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b]+1, posY[b]+1] = b /\ board[posX[b]+2, posY[b]+1] = b
      else true endif
    elseif block_type[b] == 4 then
      board[posX[b], posY[b]] = b /\ board[posX[b]+1, posY[b]+1] = b /\ board[posX[b]+1, posY[b]] = b /\ board[posX[b], posY[b]+1] = b
    elseif block_type[b] == 5 then
      if rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b]+1, posY[b]-1] = b /\ board[posX[b]+1, posY[b]-2] = b
      elseif rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b]-1, posY[b]-1] = b /\ board[posX[b]-2, posY[b]-1] = b
      else true endif
    elseif block_type[b] == 6 then
      if rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b]+1, posY[b]] = b
      elseif rotation[b] == 2 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b]+1, posY[b]] = b
      elseif rotation[b] == 3 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b]+1, posY[b]] = b /\ board[posX[b], posY[b]-1] = b
      elseif rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b], posY[b]-1] = b /\ board[posX[b], posY[b]+1] = b
      else true endif
    elseif block_type[b] == 7 then
      if rotation[b] == 0 then
      board[posX[b], posY[b]] = b /\ board[posX[b], posY[b]+1] = b /\ board[posX[b]+1, posY[b]+1] = b /\ board[posX[b]+1, posY[b]+2] = b
      elseif rotation[b] == 1 then
      board[posX[b], posY[b]] = b /\ board[posX[b]-1, posY[b]] = b /\ board[posX[b]-1, posY[b]+1] = b /\ board[posX[b]-2, posY[b]+1] = b
      else true endif
    else true endif
);


%Limita le possibili rotazioni per le forme in cui esse coincidono
constraint forall(b in blocks)(
    if block_type[b] == 1 then
    rotation[b] = 1 \/ rotation[b] = 0
    elseif block_type[b] == 4 then
    rotation[b] = 0
    elseif block_type[b] == 5 then
    rotation[b] = 1 \/ rotation[b] = 0
    elseif block_type[b] == 7 then
    rotation[b] = 1 \/ rotation[b] = 0
    else true
    endif
);


%Specifica come svolgere la ricerca della soluzione
solve :: seq_search([
    int_search(posX, first_fail, indomain_random, complete),
    int_search(posY, first_fail, indomain_random, complete),
    int_search(rotation, first_fail, indomain_min, complete),   
    ])
satisfy;

%Stampa la scacchiera
output [show(board[i,j]) ++ " " ++ if j==n then "\n" else " " endif | i,j in range]

  

