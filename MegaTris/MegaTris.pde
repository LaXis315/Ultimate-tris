void setup(){
  size(843,843);
  background(255);
  frameRate(60);
  trispng = loadImage("Tris.png");
  crosspng = loadImage("Cross.png");
  circlepng = loadImage("nCircle.png");
  int count = 0;
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){ 
      tris [count] = new Tris(width*j/3+46.0,height*i/3+46.0,186.0);
      count++;
    }
  }
}

void draw(){
  //nello stato 0 il giocatore é libero di mettere il segno in qualsiasi tris libero  
  if(mousep && tris[pos].attivo == 0 && stato == 0){
    mousep = false;
    pos2 = int(y)*3+int(x);
    if(x < 3 && y < 3 && x >= 0 && y >= 0 && (tris[pos2].attivo == 0 || tris[pos2].attivo == 1)){ //caso 1: il tris nuovo non é vinto o patto
      if(int(p) == 0)
        tris[pos].segno[pos2] = 1;
      else
        tris[pos].segno[pos2] = -1;
        
      //mi preparo per passare allo stato 1  
      p = !p; //cambio giocatore
      stato = 1; //passo allo stato 1
      reset(); //resetto lo stato di tutti i tris
      tris[pos2].attivo = 1; //secondo il funzionamento del gioco in base a dove si ha giocato nel tris, bisogna giocare nel tris della griglia corrispondente
      controllotris(tris[pos],pos); //controllo se il tris giocato é stato vinto
    }
    else if(x < 3 && y < 3 && x >= 0 && y >= 0 && (abs(tris[pos2].attivo) == 2 || tris[pos2].attivo == -1) && tris[pos].segno[pos2] == 0){ //caso 2: il tris nuovo é vinto o patto
      if(int(p) == 0)
        tris[pos].segno[pos2] = 1;
      else
        tris[pos].segno[pos2] = -1;
      //rimango nello stato 0  
      p = !p;
      reset();
      controllotris(tris[pos],pos);
    }
    rend = true;
  }
  
  // qua inizia il vero gioco
  else if(stato == 1 && mousep && pos == pos2){  
    mousep = false;
    if(x < 3 && y < 3 && x >= 0 && y >= 0 && (tris[int(y)*3+int(x)].attivo == 0 || tris[int(y)*3+int(x)].attivo == 1) && tris[pos].segno[int(y)*3+int(x)] == 0){
      pos2 = int(y)*3+int(x); //calcolo la posizione che ho cliccato e ci metto una x o un 0 in base  al turno
      if(int(p) == 0)
        tris[pos].segno[pos2] = 1;
      else
        tris[pos].segno[pos2] = -1;
        
      p = !p;
      reset();
      tris[pos2].attivo = 1;
      rend = true;
      controllotris(tris[pos],pos);
      if(abs(tris[pos2].attivo) == 2)
        stato = 0;
    }
    else if(x < 3 && y < 3 && x >= 0 && y >= 0 && (abs(tris[int(y)*3+int(x)].attivo) == 2 || tris[int(y)*3+int(x)].attivo == -1) && tris[pos].segno[int(y)*3+int(x)] == 0){
      pos2 = int(y)*3+int(x); //calcolo la posizione che ho cliccato e ci metto una x o un 0 in base  al turno
      if(int(p) == 0)
        tris[pos].segno[pos2] = 1;
      else
        tris[pos].segno[pos2] = -1;
        
      p = !p;
      stato = 0;
      reset();
      rend = true;
      controllotris(tris[pos],pos);
    }
  }
  
  else if(stato == 3){
    background(255);
    stroke(0);
    textSize(50);
    if(vittoria == 1){
      fill(#76D827);
      text("HAI VINTO GIOCATORE 1!",100,height/2);
    }
    else if(vittoria == 2){
      fill(#E51523);
      text("HAI VINTO GIOCATORE 2!",100,height/2);
    }
    else{
      fill(#791A00);
      text("PAREGGIO!",width/2-140,height/2);
    }
  }
  
  if(rend == true){
    rend = false;
    background(255);
    Render();
  }  
}
