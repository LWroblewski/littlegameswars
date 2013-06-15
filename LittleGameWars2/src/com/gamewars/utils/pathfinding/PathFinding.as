package com.gamewars.utils.pathfinding
{
  
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Player;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.TileUtils;
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
    private var mRoot:PathNode;
    /** Points calculés */
    private var mComputedPaths:Dictionary = new Dictionary();
    
    /** Constructeur */
    public function PathFinding(pWorld:World) : void
    {
      mWorld = pWorld;
    }
    
    /** Calcule tous les chemins possibles pour l'unitée */
    public function computePaths(pUnit:Unit) : PathResult
    {
      var result:PathResult = new PathResult(pUnit.getCell());
      var node:PathNode = new PathNode(null, pUnit.getCell(), result);
      node.computePaths(pUnit.mMovePoints);
      return result;
    }
    
    /** Calcule tous les ennemis que l'unitée peut cibler */
    public function computeTargets(pUnit:Unit) : Vector.<Unit>
    {
      var result:Vector.<Unit> = new <Unit>[];
      // Récupère tous les ennemis
      var opponents:Vector.<Player> = mWorld.getOpponents(pUnit.mOwner);
      // Parcours tous les ennemis
      for each (var pl:Player in opponents)
      {
        // Parcours toutes les unitées
        for each (var unit:Unit in pl.mUnits)
        {
          // Si l'unitée est à portée, on l'ajoute
          if (pUnit.getCell().getDistance(unit.getCell()) <= pUnit.mUnitType.mRange)
            result.push(unit);
        }
      }
      return result;
    }
  }
}