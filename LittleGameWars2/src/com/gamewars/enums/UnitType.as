package com.gamewars.enums
{

  public class UnitType
  {
    /** Indentifiant pour cibler toutes les unités (effets de masse). */
    public static const ALL_UNITS:String = "allUnits";
    
    public static const INFANTRY:UnitType = new UnitType("Infantry", "Infanterie", 99, 10, 10, 3, 2, 1, 1000);
    
    /** Liste des unités. */
    public static var _list:Vector.<UnitType>;
    
    public static function get list():Vector.<UnitType>
    {
      if (!_list)
      {
        _list.push(INFANTRY);
      }
      return _list;
    }
    
    /** Retourne une unité d'identifiant pId. */
    public static function getUnit(pId:String):UnitType
    {
      for each (var unitType:UnitType in list)
      {
        if (unitType.mId == pId)
        {
          return unitType;
        }
      }
      return null;
    }
    
    /** Identifiant de l'unité */
    public var mId:String;
    /** Fuel initial */
    public var mFuel:int;
    /** Munitions initiales */
    public var mAmmo:int;
    /** Points de mouvement */
    public var mMovePts:int;
    /** Vision */
    public var mVision:int;
    /** Type d'arme */
    public var mWeaponType:WeaponType;
    /** Prix de l'unité */
    public var mCost:int;
    /** Portée de tir */
    public var mRange:int;
    /** Nom du type d'unitée */
    public var mName:String;
    /** Points d'attaque */
    public var mAttack:int;
    
    /** Constructeur */
    public function UnitType(
      pId:String,
      pName:String,
      pFuel:uint, 
      pAmmo:int, 
      pMovePoints:int,
      pAttack:int,
      pVision:uint, 
      pRange:uint, 
      pCost:uint)
    {
      mId = pId;
      mName = pName;
      mFuel = pFuel;
      mAmmo = pAmmo;
      mMovePts = pMovePoints;
      mAttack = pAttack;
      mVision = pVision;
      mRange = pRange;
      mCost = pCost;
    }
  }
}