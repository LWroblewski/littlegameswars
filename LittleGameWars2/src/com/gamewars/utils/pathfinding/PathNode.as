package com.gamewars.utils.pathfinding
{
  import com.gamewars.enums.WindRose;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  public class PathNode
  {
    public var mParent:PathNode;
    public var mCell:WorldCell;
    public var mPtsLeft:int;
    private var mResult:PathResult;
    
    /** Constructeur */
    public function PathNode(pParent:PathNode, pCell:WorldCell, pResult:PathResult)
    {
      mParent = pParent;
      mCell = pCell;
      mResult = pResult;
      mResult.mCellToNode[mCell] = this;
    }
    
    /** Retourne la liste des cellules */
    public function getCells() : Vector.<WorldCell>
    {
      var result:Vector.<WorldCell> = new <WorldCell>[];
      var p:PathNode = this;
      while (p != null)
      {
        result.push(p.mCell);
        p = p.mParent;
      }
      return result;
    }
    
    /** Calcul des chemins possibles */
    public function computePaths(pMovePts:int) : void
    {
      mPtsLeft = pMovePts;
      
      var c:WorldCell;
      var p:PathNode;
      var existing:PathNode;
      // Crée un noeud dans chaque direction
      for each (var dir:WindRose in WindRose.all)
      {
        c = mCell.getCellAt(dir);
        existing = mResult.mCellToNode[c] as PathNode;
        if (c != null)
        {
          var pts:int = pMovePts-c.getMovementCost();
          // Vérifie si le mouvement est possible/plus intéressant
          if (pts >= 0 && (existing == null || existing.mPtsLeft < pts))
          {
            p = new PathNode(this, c, mResult);
            p.computePaths(pts);
          }
        }
      }
    }
  }
}