void mousePressed(){
  mousep = true;
  x = map(mouseX,0,width,0,3);
  y = map(mouseY,0,height,0,3);
  pos = int(y)*3+int(x);  //mappo il mouse per capire quale tris é stato scelto
  x = map(mouseX,tris[pos].x,tris[pos].x+tris[pos].l,0,3);
  y = map(mouseY,tris[pos].y,tris[pos].y+tris[pos].l,0,3);
  pos3 = int(y)*3+int(x);;
}

void cambiosegno(){
  //adesso che siamo sicuri che il giocatore ha giocato nel tris giusto il pos2 puó essere sovrascritto
  pos2 = pos3;
  if(int(p) == 0)
    tris[pos].segno[pos2] = 1;
  else
    tris[pos].segno[pos2] = -1;
        
  p = !p;
  reset();  
}

void controllotris(Tris trisc,int pos){ //controlla il trisc(trisc) per vedere se é stato vinto
  //controllo il tris per vedere se é patta
  for(int i = 0; i < 9; i++){
    if(trisc.segno[i] == 0)
      break;
    else if(i == 8)
      tris[pos].attivo = -1;    
  }
  //controllo verticali e orizzontali
  for(int i = 0; i < 3; i++){
    if(trisc.segno[3*i]+trisc.segno[3*i+1]+trisc.segno[3*i+2] == 3 || trisc.segno[i]+trisc.segno[i+3]+trisc.segno[i+6] == 3)
      tris[pos].attivo = 2;
    else if(trisc.segno[3*i]+trisc.segno[3*i+1]+trisc.segno[3*i+2] == -3 || trisc.segno[i]+trisc.segno[i+3]+trisc.segno[i+6] == -3)
      tris[pos].attivo = -2;
  }
  //controllo le diagonali
  if(trisc.segno[0] + trisc.segno[4] + trisc.segno[8] == 3 || trisc.segno[2] + trisc.segno[4] + trisc.segno[6] == 3)
    tris[pos].attivo = 2;
  else if(trisc.segno[0] + trisc.segno[4] + trisc.segno[8] == -3 || trisc.segno[2] + trisc.segno[4] + trisc.segno[6] == -3)
    tris[pos].attivo = -2;
    
  //se il tris viene vinto controllo la griglia maggiore
  if(tris[pos].attivo == 2 || tris[pos].attivo == -2 || tris[pos].attivo == -1)
    controlloultimate();
}

void controlloultimate(){
  //controllo se l'ultimate é patta
  for(int i = 0; i < 9; i++){
    if(tris[i].attivo == 0 || tris[i].attivo == 1)
      break;
    else if(i == 8){ 
      stato = 3;
    }  
  }
  //controllo verticali e orizzontali
  for(int i = 0; i < 3; i++){
    if(tris[3*i].attivo+tris[3*i+1].attivo+tris[3*i+2].attivo == 6 || tris[i].attivo+tris[i+3].attivo+tris[i+6].attivo == 6)
      vittoria = 1;
    else if(tris[3*i].attivo+tris[3*i+1].attivo+tris[3*i+2].attivo == -6 || tris[i].attivo+tris[i+3].attivo+tris[i+6].attivo == -6)
      vittoria = 2;
  }
  //controllo le diagonali
  if(tris[0].attivo + tris[4].attivo + tris[8].attivo == 6 || tris[2].attivo + tris[4].attivo + tris[6].attivo == 6)
    vittoria = 1;
  else if(tris[0].attivo + tris[4].attivo + tris[8].attivo == -6 || tris[2].attivo + tris[4].attivo + tris[6].attivo == -6)
    vittoria = 2;  
    
  if(vittoria == 1 || vittoria == 2)
    stato = 3;
}

void Render(){  //renderizza tutto
  //tris
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){ 
      colori(i*3+j);
      image(trispng,width*j/3+46,height*i/3+46,186,186);
    }
  }
  //contorni
  if(p == true)
  stroke(#E51523); //rosso
  else
  stroke(#76D827); //verde
  
  strokeWeight(strokew);
  line(0,height/3-1,width,height/3-1);
  line(0,2*height/3-2,width,2*height/3-2);
  line(width/3-1,0,width/3-1,height);
  line(2*width/3-2,0,2*width/3-2,height);
  
  rendersegni();
  
}

void colori(int i){
  strokeWeight(2); 
  if(tris[i].attivo == 1){
    fill(#FBFF46); //giallo
    if(!p)
      stroke(#76D827); //verde
    else
      stroke(#E51523); //rosso
  }
  else if(tris[i].attivo == 2){
    fill(#76D827); //verde
    stroke(#76D827); //verde
  }
  else if(tris[i].attivo == -2){
    fill(#E51523); //rosso
    stroke(#E51523); //rosso
  }
  else if(tris[i].attivo == -1){
    fill(#791A00); //nero
    stroke(#791A00); //nero
  }
  else{
    fill(255);
    stroke(255);
  }
      
    rect(tris[i].x,tris[i].y,tris[i].l,tris[i].l);    
}

void rendersegni(){
  for(int i = 0; i < 9; i++){
    if(tris[i].attivo == 0 || tris[i].attivo == 1)
      for(int j = 0; j < 9; j++){
        
        float x = tris[i].x+tris[j].l*(j%3)/3  + 16;
        float y = tris[i].y+tris[j].l*(j/3)/3  + 16;
        
        if(tris[i].segno[j] == -1){
          image(crosspng,x,y);
        }
        else if(tris[i].segno[j] == 1){
          image(circlepng,x,y);
        }
      }
  }
}

void reset(){
  for(int i = 0; i < 9; i++){
    if(tris[i].attivo == 1)
      tris[i].attivo = 0;  
  }
}
