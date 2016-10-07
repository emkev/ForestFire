
/* 2016.10.07 */

int [][][] pix = new int[2][400][400] ;
int toDraw = 0 ;

/*  tree-state , burning-state , empty-state */
int tree = 0 ;
int burningTree = 1 ;
int emptySite = 2 ;

int x_limit = 400 ;
int y_limit = 400 ;

color brown = color(80 , 50 , 10);
color red   = color(255 , 0 , 0);
color green = color(0 , 255 , 0);

/*  growth rate  and burning rate  */
float pGrowth = 0.01 ;
float pBurn = 0.00006 ;


/*  */
boolean prob(float p)
{
  if(random(0 , 1) < p)
    return true ;
  else
    return false ;
}

void setup()
{
  size(x_limit , y_limit);
  frameRate(60);
 
  /*  initialize  */
  for(int x = 0 ; x < x_limit ; x++)
  {
    for(int y = 0 ; y < y_limit ; y++)
    {
      pix[toDraw][x][y] = emptySite ;
    }
  } 
  
}


void update()
{
  int x , y , dx , dy ;
  int cell , chg , burningTreeCount ;
  /*  means the computing process  */
  int toCompute = (toDraw == 0) ? 1 : 0 ;
  
  
  for(x = 1 ; x < x_limit - 1 ; x++)
  {
    for(y = 1 ; y < y_limit - 1 ; y++)
    {      
      
      /*  survey all burning points around the current point . start */
      burningTreeCount = 0 ;
      for(dx = -1 ; dx <= 1 ; dx++)
      {
        for(dy = -1 ; dy <= 1 ; dy++)
        {
          if(dx == 0 && dy == 0)
            continue ;
          else if(pix[toDraw][x+dx][y+dy] == burningTree)
            burningTreeCount++ ;
        } /*  for(dy = -1 ; dy <= 1 ; dy++)  */
      } /*  for(dx = -1 ; dx <= 1 ; dx++)  */
      /*  survey all burning points around the current point . end */


      /*  set next state from surveying . start  */
      cell = pix[toDraw][x][y] ;
      if(cell == burningTree) 
        chg = emptySite ;
      else if((cell == emptySite) && (prob(pGrowth)))
        chg = tree ;
      else if((cell == tree) && (prob(pBurn)))
        chg = burningTree ;
      else if((cell == tree) && (burningTreeCount > 0))
        chg = burningTree ;
      else
        chg = cell ;
      /*  set next state from surveying . end  */
        
        
      /*  change next state for the point  */
      pix[toCompute][x][y] = chg ;

      
    }  /*  for(y = 1 ; y < y_limit - 1 ; y++)  */
  } /*  for(x = 1 ; x < x_limit - 1 ; x++)  */
  
}


void draw()
{
  update();
  
  for(int x = 0 ; x < x_limit ; x++)
  {
    for(int y = 0 ; y < y_limit ; y++)
    {
      if(pix[toDraw][x][y] == tree)
        stroke(green);
      else if(pix[toDraw][x][y] == burningTree)
        stroke(red);
      else
        stroke(brown);
        
      point(x , y);
      
    }  /*  for(int y = 0 ; y < y_limit ; y++)  */
  }  /*  for(int x = 0 ; x < x_limit ; x++)  */

  toDraw = (toDraw == 0) ? 1 : 0 ;
  
}


