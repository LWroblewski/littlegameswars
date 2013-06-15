package com.gamewars.utils.pathfinding
{
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;

  /**
  * Resultat d'une recherche de chemins
  */
  public class PathResult
  {
    /** Toutes les cellules disponibles */
    public var mCellToNode:Dictionary = new Dictionary(); // [WorldCell] => PathNode
    /** Origine de tous les chemins */
    public var mRootCell:WorldCell;
    
    /** Constructeur */
    public function PathResult(pRootCell:WorldCell)
    {
      mRootCell = pRootCell;
    }
    
    /** Retourne toutes les cellules des noeuds */
    public function getCells() : Vector.<WorldCell>
    {
      var result:Vector.<WorldCell> = new <WorldCell>[];
      for (var key:* in mCellToNode)
      {
        result.push(key as WorldCell);
      }
      return result;
    }
    
    /** Indique si il y a un chemin possible vers la cellule passée en paramètres */
    public function hasPathTo(pCell:WorldCell) : Boolean
    {
      return mCellToNode[pCell] != undefined;
    }
    
    /** Retourne le noeud qui permet de voyager vers la cellule */
    public function getNode(pCell:WorldCell) : PathNode
    {
      return mCellToNode[pCell];
    }
  }
}