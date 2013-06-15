package com.gamewars.managers
{
  import com.gamewars.structures.Unit;
  import com.gamewars.world.World;

  public class UnitManager
  {
    /** Liste des unitées */
    private var mUnits:Vector.<Unit> = new <Unit>[];
    /** Réference vers le monde */
    private var mWorld:World;
    
    /** Constructeur */
    public function UnitManager(pWorld:World)
    {
      mWorld = pWorld;
    }
    
    /** Ajoute une unitée */
    public function addUnit(pUnit:Unit) : void
    {
      mUnits.push(pUnit);
    }
    
    /** Enlève une unitée */
    public function removeUnit(pUnit:Unit) : void
    {
      mUnits.splice(mUnits.indexOf(pUnit), 1);
    }
  }
}