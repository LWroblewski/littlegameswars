package com.gamewars.enums
{
  public class WindRose
  {
    public static const NORTH:WindRose = new WindRose('Nord');
    public static const EAST:WindRose = new WindRose('Est');
    public static const SOUTH:WindRose = new WindRose('Sud');
    public static const WEST:WindRose = new WindRose('Ouest');
    public static const NORTH_EAST:WindRose = new WindRose('Nord-Est');
    public static const NORTH_WEST:WindRose = new WindRose('Nord-Ouest');
    public static const SOUTH_EAST:WindRose = new WindRose('Sud-Est');
    public static const SOUTH_WEST:WindRose = new WindRose('Sud-Ouest');
    
    public static const all:Array = [NORTH, EAST, SOUTH, WEST];
    public static const allExt:Array = [NORTH, EAST, SOUTH, WEST, NORTH_EAST, NORTH_WEST, SOUTH_EAST, SOUTH_WEST];
    
    private var mName:String;
    
    /** Constructeur */
    public function WindRose(pName:String)
    {
      mName = pName;
    }
  }
}