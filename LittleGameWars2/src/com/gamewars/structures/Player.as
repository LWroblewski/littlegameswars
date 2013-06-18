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
    /** Liste des batiments du joueur */
    public var mBuildings:Vector.<BaseEntity> = new <BaseEntity>[];
    /** Exploration de la map */
    public var mVisitedCells:Vector.<WorldCell> = new <WorldCell>[];
    /** Argent du joueur */
    public var mGold:int = 0;
    
    /** Constructeur */
    public function Player()
    {
    }
    
    /** Initialisation du joueur */
    public function initialize(pCommander:CommanderType, pGold:int, pUnits:Vector.<Unit>) : void
    {
      mCommander = pCommander;
      mGold = pGold;
      mUnits = pUnits;
    }
    
    /** Ajoute une unitée au joueur */
    public function addUnit(pUnit:Unit) : void
    {
      mUnits.push(pUnit);
      pUnit.mOwner = this;
    }
  }
}