package com.gamewars.utils.pathfinding
{
  
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Unit;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  public class PathFinding
  {
    /** Réference vers l'unité */
    private var mUnit:Unit;
    /** Reference vers le monde */
    private var mWorld:World;
    /** Racine du pathFinding */
    private var mRoot:PathPoint;
    /** Points calculés */
    private var mComputedPaths:Dictionary = new Dictionary();
    
    /** Constructeur */
    public function PathFinding(pWorld:World) : void
    {
      mWorld = pWorld;
    }
    
    /** Calcule tous les chemins possibles pour l'unitée */
    public function computeReachables(pUnit:Unit) : Dictionary
    {
      var cell:WorldCell = pUnit.getCell();
      mRoot = new PathPoint(null, cell, mWorld);
      mComputedPaths = new Dictionary();
      mComputedPaths[cell] = mRoot;
      mRoot.computeReachables(pUnit.mMovePoints, mComputedPaths);
      return mComputedPaths;
    }
    
    /** Calcule toutes les cellules que l'unitée peut cibler */
    public function computeTargetables(pUnit:Unit) : Vector.<WorldCell>
    {
      var result:Vector.<WorldCell> = new <WorldCell>[];
      spreadTest(
        function test(pCell:WorldCell) : Boolean
        {
          if (pCell != pUnit.getCell() && 
            pCell.getUnit() != null &&
            result.indexOf(pCell) == -1 &&
            pUnit.getCell().getDistance(pCell) <= pUnit.mRange)
          {
            result.push(pCell);
            return true;
          }
          return false;
        }, pUnit.getCell());
      return result;
    }
    
    /** 
     * Effectue un test sur toutes les cases adjacentes et propage si le test est valide
     * @param pTestFunction function(pCell:WorldCell) : Boolean 
     */
    public function spreadTest(pFunction:Function, pCell:WorldCell) : void
    {
      for each (var dir:WindRose in WindRose.all)
      {
        var cell:WorldCell = pCell.getCellAt(dir);
        if (pCell != null && pFunction(cell))
        {
          spreadTest(pFunction, cell);
        }
      }
    }
  }
}