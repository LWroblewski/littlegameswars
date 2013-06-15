package com.gamewars.utils
{
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Unit;
  import com.gamewars.world.WorldCell;

  public class TileUtils
  {
    /** 
     * Effectue un test sur toutes les cases adjacentes et propage si le test est valide
     * @param pTestFunction function(pCell:WorldCell, pData:*) : Boolean
     * @param pCell La cellule initiale
     * @param pData Une donnée passé à la callback 
     */
    public static function spreadTest(pTestFunction:Function, pRootCell:WorldCell, pData:*) : Vector.<WorldCell>
    {
      var result:Vector.<WorldCell> = new <WorldCell>[];
      spreadTestInternal(pTestFunction, pRootCell, pData, result);
      return result;
    }
    
    /** Calcul de toutes les cellules visibles par l'unitée passée en paramètres */
    public static function computeVisibility(pFrom:WorldCell, pVisionPts:uint) : Vector.<WorldCell>
    {
      return spreadTest(visionTest, pFrom, {from:pFrom, vision:pVisionPts});
    }
    
    /** Test de la visibilité d'une cellule par une unitée */
    private static function visionTest(pCell:WorldCell, pData:*) : Boolean
    {
      return WorldCell(pData.from).getDistance(pCell) <= pData.vision;
    }
    
    /** Fonction recursive de test de propagation */
    private static function spreadTestInternal(pTestFunction:Function, pCell:WorldCell, pData:*, pVisitedCells:Vector.<WorldCell>, pUncheckDirs:Array=null) : void
    {
      if (pCell == null) return;
      if (pVisitedCells == null) pVisitedCells = new <WorldCell>[];
      // Vérifie si la propagation est autorisée
      if (pTestFunction(pCell, pData))
      {
        pVisitedCells.push(pCell);
        
        for each (var dir:WindRose in WindRose.all)
        {
          if (pUncheckDirs != null && pUncheckDirs.indexOf(dir) != -1)
            continue;
          spreadTestInternal(pTestFunction, pCell.getCellAt(dir), pData, pVisitedCells, [dir.getInverse()]);
        }
      }
    }
  }
}