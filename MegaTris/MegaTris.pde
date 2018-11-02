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
  /* Lo stato 0 e lo stato 1 hanno entrambi un caso dove rimangono nel loro stato e un caso dove cambiano lo stato nell'altro
     Lo stato 0 é utile quando il player é libero di scegliere un qualsiasi tris libero, ovviamente la sua scelta puó portare a bloccare il secondo giocatore
     oppure a lasciarlo nello stato 0
     Lo stato 1 invece é utile quando il player é costretto a giocare in un tris specifico. La sua scelta puó costringere l'avversario a giocare in un tris specifico oppure a passare allo stato 0
     con le sue conseguenze*/
  
  //STATO 0 
  //per fare qualcosa il giocatore deve essere nello stato 0, cliccare un tris non vinto e la sua casella deve essere libera
  if(stato == 0 && mousep && x < 3 && y < 3 && x >= 0 && y >= 0 && tris[pos].attivo == 0 && tris[pos].segno[pos3] == 0){
    //pos2 = pos3;
    
    if(tris[pos3].attivo == 0 || tris[pos3].attivo == 1){ //caso 1: il tris nuovo non é vinto o patto
      cambiosegno();
      controllotris(tris[pos],pos); //controllo se il tris giocato é stato vinto
      
      //mi preparo per passare allo stato 1  
      if(abs(tris[pos2].attivo) != 2 && tris[pos2].attivo != -1 && stato != 3){ //puó capitare che la nostra mossa lasci giocare l'avversario nello stesso tris e allo stesso tempo questo venga vinto. in questo caso particolare si passa allo stato 0
        stato = 1;//passo allo stato 1
        tris[pos2].attivo = 1; //secondo il funzionamento del gioco in base a dove si ha giocato nel tris, bisogna giocare nel tris della griglia corrispondente
      }
    }
    
    else if(abs(tris[pos3].attivo) == 2 || tris[pos3].attivo == -1){ //caso 2: il tris nuovo é vinto o patto
      cambiosegno();
      controllotris(tris[pos],pos);
    }
    
    mousep = false;
    rend = true;
  }
  
  //STATO 1
  //per fare qualcosa il giocatore deve essere nello stato 1, cliccare il tris corrispondente alla casella dell'avversarsio e la nuova casella deve essere libera
  else if(stato == 1 && mousep && x < 3 && y < 3 && x >= 0 && y >= 0 && pos == pos2 && tris[pos].segno[pos3] == 0){  
    
    if(tris[pos3].attivo == 0 || tris[pos3].attivo == 1){
      cambiosegno();
      controllotris(tris[pos],pos);
      
      if(abs(tris[pos2].attivo) == 2 && stato != 3) //puó capitare che la nostra mossa ci lasci nel tris e allo stesso tempo questo venga vinto. in questo caso particolare si passa allo stato 0
        stato = 0;
      else
        tris[pos2].attivo = 1; //in questo caso l'avversario giocherá in un tris preciso
        
    }
    
    else if(abs(tris[pos3].attivo) == 2 || tris[pos3].attivo == -1){
      cambiosegno();
      controllotris(tris[pos],pos);
      
      if(stato != 3)
        stato = 0; //in questo caso l'avversario gioca liberamente
    }
    
    mousep = false;
    rend = true;
  }
  
  if(stato == 3){
    //float r = sqrt(pow(mouseX-width/2,2)+pow(mouseY-height/2,2));
    //float n = map(r,0,sqrt(pow(width,2)+pow(height,2))/2,127,255);
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
  
  //grazie a rend viene renderizzato tutto a schermo
  if(rend == true){
    rend = false;
    background(255);
    Render();
  }  
}
