package com.gamewars.structures
{
  public class Player
  {
    /** Commander du joueur */
    public var mCommander:CommanderType;
    /** Liste des unitées du joueur */
    public var mUnits:Vector.<Unit> = new <Unit>[];
    
    /** Constructeur */
    public function Player()
    {
    }
  }
}