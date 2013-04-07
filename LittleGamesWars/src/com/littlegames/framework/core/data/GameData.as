package com.littlegames.framework.core.data
{
  import com.littlegames.framework.core.engine.render.GridLayout;
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
    /** Layout */
    public var layout:GridLayout = new GridLayout(20, 20);
    // ------------------------------------------------------------------------
    /** Position du curseur */
    public var cursorPosition:Point = new Point();
    public function getTileUnderCursor() : Tile
    {
      var x:uint = layout.originToTile(cursorPosition.x, cursorPosition.y).x;
      var y:uint = layout.originToTile(cursorPosition.x, cursorPosition.y).y;
      return tileMap.getTileAt(x, y);
    }
    public function getUnitUnderCursor() : UnitInstance
    {
      // TODO
      return new UnitInstance(Units.INFANTRY, 10, 5, 5);
    }
    // ------------------------------------------------------------------------
    /** Temps écoulé depuis la dernière frame */
    public var ellapsedTime:Number = 0;
  }
}