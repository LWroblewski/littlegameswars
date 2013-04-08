package com.littlegames.framework.core.data
{
  import com.littlegames.framework.core.engine.render.TileGridLayout;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.entities.unit.Units;
  
  import flash.geom.Point;

  /** Classe de model de données du jeu */
  public class GameData
  {
    // ------------------------------------------------------------------------
    // Logic data
    // ------------------------------------------------------------------------
    /** La tilemap */
    public var tileMap:TileMap = null;
    /** Liste des joueurs */
    public var listPlayers:Vector.<Player> = new <Player>[];
    
    // ------------------------------------------------------------------------
    // Graphic data
    // ------------------------------------------------------------------------
    /** Temps écoulé depuis la dernière frame */
    public var ellapsedTime:Number = 0;
  }
}