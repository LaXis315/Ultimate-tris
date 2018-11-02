//gioco
int stato = 3; // stato gioco di p
/*
Caso 0: Inizio gioco, il p1 sceglie il tris di inizio
Caso 1: Adesso il tris viene scelto in base a dove si gioca in ogni tris
Caso 3: Il gioco é vinto o patto
*/
boolean p = boolean(0); // segna il turno dei giocatori (0,1) inizia sempre con 0
float x,y;
int pos,pos2,pos3;//serve ricordare la posizione nel tris per capire dove giocherá il secondo giocatore, il pos3 é precedente al pos2
//se 0 = verde se 1 = rosso
int vittoria = 0;  //quando vinci il gioco segno il vincitore  1 = giocatore 1; 2 = giocatore 2; 0 = patta;



//rendering
boolean rend = true; //se bisogna renderizzare qualcosa diventa vero
PImage trispng,crosspng,circlepng; //immagine del tris

//tris
Tris [] tris = new Tris[9];
class Tris{
  float x,y,l;
  int attivo = 0; //memorizza se attivo 
  //0 = inutilizzato
  //1 = sta venendo usato
  //2 = vinto da p1; -2 = vinto da p2; -1 = pareggio;
  int [] segno = new int[9]; //memorizza il segno di una casella (0,1,2) 0 = vuota
  
  Tris(float posx,float posy,float lato){
    x = posx;
    y = posy;
    l = lato;
  }
}

//code 
boolean mousep = false;
