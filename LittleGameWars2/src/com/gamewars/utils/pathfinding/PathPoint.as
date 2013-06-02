package com.gamewars.utils.pathfinding
{
  import com.gamewars.enums.WindRose;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  public class PathPoint
  {
    private var mWorld:World;
    public var mParent:PathPoint;
    public var mCell:WorldCell;
    public var mMvtPtsLeft:int;
    
    /** Constructeur */
    public function PathPoint(pParent:PathPoint, pCell:WorldCell, pWorld:World)
    {
      mParent = pParent;
      mCell = pCell;
    }
    
    /** Retourne le chemin qui ramène a ce point */
    public function getPath() : Path
    {
      var result:Path = new Path();
      var pt:PathPoint = this;
      while (pt)
      {
        result.mPoints.unshift(pt);
        pt = pt.mParent;
      }
      return result;
    }
    
    // TODO Factoriser avec PathFinding.spread ???
    /** Calcule toutes les cellules atteignables avec le nombre de points de mouvement spécifiés */
    public function computeReachables(pMovePts:int, pResult:Dictionary) : void
    {
      // Sauvegarde les points restants
      mMvtPtsLeft = pMovePts;
      
      if (mMvtPtsLeft == 0)
        return;
      
      // Parcours toutes les directions
      for each (var dir:WindRose in WindRose.all)
      {
        // Récupère la cellule adjacente
        var cell:WorldCell = mCell.getCellAt(dir);
        if (!cell)
          continue;
        // Calcul le cout du mouvement
        var mvtLeft:int = mMvtPtsLeft - cell.getMovementCost();
        if (mvtLeft >= 0)
        {
          var child:PathPoint = new PathPoint(this, cell, mWorld);
          
          // Sauvegarde le mouvement le moins couteux
          if (pResult[cell] == undefined || (pResult[cell] as PathPoint).mMvtPtsLeft < mvtLeft)
          {
            pResult[cell] = child;
            // Propage le calcul si on a encore des points de mouvements
            if (mvtLeft > 0)
              child.computeReachables(mvtLeft, pResult);
          }
        }
      }
    }
  }
}