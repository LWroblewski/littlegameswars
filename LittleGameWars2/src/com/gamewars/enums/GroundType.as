package com.gamewars.enums
{
  public class GroundType
  {
    public static const PLAIN:GroundType = new GroundType(0, 'Plaine', 1, 'PLAIN');
    public static const MOUNTAIN:GroundType = new GroundType(1, 'Montagne', 2, 'MOUNTAIN');
    public static const FOREST:GroundType = new GroundType(2, 'Forêt', 1, 'FOREST');
    public static const WATER:GroundType = new GroundType(3, 'Eau', 3, 'WATER');
    
    public static var all:Array = [PLAIN, MOUNTAIN, FOREST, WATER];
    
    /** Nom du terrain */
    public var mName:String;
    /** Préfixe des textures de terrain */
    public var mTexPrefix:String;
    /** Cout de mouvement */
    public var mMovementCost:uint;
    /** Identifiant de tile */
    public var mId:uint;
    
    /** Retourne le terrain en fonction de l'id */
    public static function fromId(pId:uint) : GroundType
    {
      for each (var g:GroundType in all)
      {
        if (g.mId == pId)
          return g;
      }
      throw new Error('Terrain invalide');
    }
    
    /** Constructeur */
    public function GroundType(pId:uint, pName:String, pMovementCost:uint, pTexPrefix:String)
    {
      mId = pId;
      mName = pName;
      mMovementCost = pMovementCost;
      mTexPrefix = pTexPrefix;
    }
  }
}