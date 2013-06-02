package com.gamewars.enums
{

  public class UnitType
  {
    public static const INFANTRY:UnitType = new UnitType("Infanterie", 99, 10, 10, 2, 1, 1000);

      /** Fuel initial */
    public var mFuel:uint;
    /** Munitions initiales */
    public var mAmmo:int;
    /** Points de mouvement */
    public var mMovePts:int;
    /** Vision */
    public var mVision:uint;
    /** Type d'arme */
    public var mWeaponType:WeaponType;
    /** Prix de l'unité */
    public var mCost:uint;
    /** Portée de tir */
    public var mRange:uint;
    /** Nom du type d'unitée */
    public var mName:String;
    
    /** Constructeur */
    public function UnitType(
      pName:String,
      pFuel:uint, 
      pAmmo:int, 
      pMovePoints:int, 
      pVision:uint, 
      pRange:uint, 
      pCost:uint)
    {
      mName = pName;
      mFuel = pFuel;
      mAmmo = pAmmo;
      mMovePts = pMovePoints;
      mVision = pVision;
      mRange = pRange;
      mCost = pCost;
    }
  }
}