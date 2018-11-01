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
  if(!mousePressed && stop == true){
    stop = false;
  }
    
    
  if(stato == 0){
    //reset();
    if(mousep && tris[pos].attivo == 0){
      tris[pos].attivo = 1;
      float x = map(mouseX,tris[pos].x,tris[pos].x+tris[pos].l,0,3);
      float y = map(mouseY,tris[pos].y,tris[pos].y+tris[pos].l,0,3);
      pos2 = int(y)*3+int(x);
      if(x < 3 && y < 3 && x >= 0 && y >= 0){
        int giocatore; //1 se giocatore 1 -1 se giocatore 2
        if(int(p) == 0)
          giocatore = 1;
        else
          giocatore = -1;
        tris[pos].segno[pos2] = giocatore;
        //mi preparo per passare allo stato 1  
        p = !p;
        stop = true;
        rend = true;
        stato = 1;
        reset(); //resetto lo stato di tutti i tris
        tris[pos2].attivo = 1; //secondo il funzionamento del gioco in base a dove si ha giocato nel tris, bisogna giocare nel tris della griglia corrispondente
      }   
      mousep = false;
    }
  }
  
  // qua inizia il vero gioco
  else if(stato == 1 && mousep && pos == pos2){  
    mousep = false;
    float x = map(mouseX,tris[pos].x,tris[pos].x+tris[pos].l,0,3);
    float y = map(mouseY,tris[pos].y,tris[pos].y+tris[pos].l,0,3);
    
    if(x < 3 && y < 3 && x >= 0 && y >= 0 && tris[int(y)*3+int(x)].attivo <= 1 && tris[pos].segno[int(y)*3+int(x)] == 0){
      int giocatore; //1 se giocatore 1 -1 se giocatore 2
      pos2 = int(y)*3+int(x); //calcolo la posizione che ho cliccato e ci metto una x o un 0 in base  al turno
      if(int(p) == 0)
        giocatore = 1;
      else
        giocatore = -1;
      tris[pos].segno[pos2] = giocatore;
      p = !p;
      reset();
      tris[pos2].attivo = 1;
      rend = true;
      controllotris(tris[pos],pos);
      if(tris[pos2].attivo > 1)
        stato = 0;
    }
    else if(x < 3 && y < 3 && x >= 0 && y >= 0 && tris[int(y)*3+int(x)].attivo > 1){
      int giocatore; //1 se giocatore 1 -1 se giocatore 2
      pos2 = int(y)*3+int(x); //calcolo la posizione che ho cliccato e ci metto una x o un 0 in base  al turno
      if(int(p) == 0)
        giocatore = 1;
      else
        giocatore = -1;
      tris[pos].segno[pos2] = giocatore;
      p = !p;
      reset();
      stato = 0;
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
