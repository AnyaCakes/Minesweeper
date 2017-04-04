

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS=20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 50;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
PImage img;
PImage hap;
void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
        buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i=0; i<NUM_ROWS; i++)
        for (int k=0; k<NUM_COLS; k++){
            buttons[i][k] = new MSButton(i,k);
        }
    
    for (int i=0; i<=NUM_BOMBS; i++)
    {
        setBombs();
    }
    img = loadImage("sad.png");
    hap = loadImage("happy.png");
}
public void setBombs()
{
        int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);


    while(bombs.contains(buttons[row][col]))
    {
        row = (int)(Math.random()*20);
        col = (int)(Math.random()*20);
    }
    
    bombs.add(buttons[row][col]);   
}


public void draw ()
{
   // background( 0 );
    if(isWon())
        displayWinningMessage();

}
public boolean isWon()
{
    for (int i=0; i<NUM_ROWS; i++)
        for (int k=0; k<NUM_COLS; k++)
        {
            if(!buttons[i][k].isClicked() && !bombs.contains(buttons[i][k]) )
                return false;
        }
        return true;
}
public void displayLosingMessage()
{
        fill(0,0,0);
    textMode(CENTER);    
    text("LOSER", 200, 450);
    fill(200,0,0);
    for (int i=0; i<NUM_ROWS; i++){
        for (int k=0; k<NUM_COLS; k++)
        {
            if(bombs.contains(buttons[i][k]))
                buttons[i][k].setClicked(true);
        }

    }
}
public void displayWinningMessage()
{
        fill(0,0,0);
    background(255, 255, 255);
    image(hap, 200, 400, 100, 100);

    text("You won :D", 200, 450);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc)
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
        public void setClicked(boolean meh)
    {
        clicked=meh;
    }
    public void mousePressed () 
    {
        if(mouseButton==LEFT)
        {
            clicked = true;
        }
        if(mouseButton==RIGHT)
            marked=!marked;
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(countBombs(r,c)+"");
        else if(countBombs(r,c)==0){
            if(isValid(r-1,c)) 
                if(!buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();
            if(isValid(r,c-1)) 
                if(!buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
            if(isValid(r-1,c-1))
                if(!buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c)) 
                if(!buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
            if(isValid(r,c+1)) 
                if(!buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
            if(isValid(r+1,c+1))
                if(!buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c+1))
                if(!buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
            if(isValid(r+1,c-1))
                if(!buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
       else if( clicked && bombs.contains(this) ) {
            fill(255,0,0);
            image(img, 200, 400, 100, 100);

            displayLosingMessage();
        }
        else if(clicked)
            fill( 200 );

        else 
            for(int i = 0; i < 200; i++)
            fill( i*.5, i*.75, i*.5 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
          if(r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
          int numBombs = 0;

        if(isValid(row-1, col))
            if(bombs.contains(buttons[row-1][col]))
            {
                numBombs+=1;
            }
        if(isValid(row, col-1))
            if(bombs.contains(buttons[row][col-1]))
            {
                numBombs+=1;
            }
        if(isValid(row-1, col-1))
            if(bombs.contains(buttons[row-1][col-1]))
            {
                numBombs+=1;
            }
        if(isValid(row+1, col))
            if(bombs.contains(buttons[row+1][col]))
            {
                numBombs+=1;
            }
        if(isValid(row, col+1))
            if(bombs.contains(buttons[row][col+1]))
            {
                numBombs+=1;
            }
        if(isValid(row+1, col+1))
            if(bombs.contains(buttons[row+1][col+1]))
            {
                numBombs+=1;
            }
        if(isValid(row-1, col+1))
            if(bombs.contains(buttons[row-1][col+1]))
            {
                numBombs+=1;
            }
        if(isValid(row+1, col-1))
            if(bombs.contains(buttons[row+1][col-1]))
            {
                numBombs+=1;
            }
        return numBombs;
    }
}

