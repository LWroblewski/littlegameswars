package com.littlegames.framework.core.level
{
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.entities.unit.UnitType;

  public class Level
  {
    /** TileMap du niveau */
    private var _tileMap:TileMap;
    
    /** Liste des unitées */
    private var _unitList:Vector.<UnitType>;
    
    /** Classe de définition de niveau */
    public function Level()
    {
    }
  }
}