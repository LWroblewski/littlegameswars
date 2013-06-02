package com.gamewars.enums
{
  public class WindRose
  {
    public static const NORTH:WindRose = new WindRose('Nord');
    public static const EAST:WindRose = new WindRose('Est');
    public static const SOUTH:WindRose = new WindRose('Sud');
    public static const WEST:WindRose = new WindRose('Ouest');
    
    public static const all:Array = [NORTH, EAST, SOUTH, WEST];
    
    private var mName:String;
    
    /** Constructeur */
    public function WindRose(pName:String)
    {
      mName = pName;
    }
  }
}