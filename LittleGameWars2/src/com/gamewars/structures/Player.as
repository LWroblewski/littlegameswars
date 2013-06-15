package com.gamewars.structures
{
  import com.gamewars.enums.CommanderType;
  import com.gamewars.world.WorldCell;

  public class Player
  {
    /** Commander du joueur */
    public var mCommander:CommanderType;
    /** Liste des unitées du joueur */
    public var mUnits:Vector.<Unit> = new <Unit>[];
    /** Exploration de la map */
    public var mVisitedCells:Vector.<WorldCell> = new <WorldCell>[];
    
    /** Constructeur */
    public function Player()
    {
    }
    
    /** Ajoute une unitée au joueur */
    public function addUnit(pUnit:Unit) : void
    {
      mUnits.push(pUnit);
      pUnit.mOwner = this;
    }
  }
}