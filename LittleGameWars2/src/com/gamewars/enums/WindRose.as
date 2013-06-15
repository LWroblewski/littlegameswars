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
    
    /** Retourne la direction inverse */
    public function getInverse() : WindRose
    {
      switch(this)
      {
        case NORTH:
          return SOUTH;
          break;
        case EAST:
          return WEST;
          break;
        case SOUTH:
          return NORTH;
          break;
        case WEST:
          return EAST;
          break;
        case NORTH_EAST:
          return SOUTH_WEST;
          break;
        case NORTH_WEST:
          return SOUTH_EAST;
          break;
        case SOUTH_EAST:
          return NORTH_WEST;
          break;
        case SOUTH_WEST:
          return NORTH_EAST;
          break;
        default:
          throw new Error('Invalid direction');
      }
    }
  }
}