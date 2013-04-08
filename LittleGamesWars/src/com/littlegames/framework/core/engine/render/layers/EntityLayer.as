package com.littlegames.framework.core.engine.render.layers
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.Player;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.GridLayout;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;
  
  /**
  * Gère l'affichage de tous les éléments du jeu
  */
  public class EntityLayer extends Sprite
  {
    /** Layer de la TileMap */
    private var _layerTileMap:Sprite;
    /** Layer des unitées */
    private var _layerUnits:Sprite;
    
    /** Constructeur */
    public function EntityLayer()
    {
      super();
      
      _layerTileMap = new Sprite();
      addChild(_layerTileMap);
      _layerUnits = new Sprite();
      addChild(_layerUnits);
    }
    
    /** Initialize le jeu */
    public function initialize(pGameData:GameData) : void
    {
      buildTileMap(pGameData);
      addUnits(pGameData);
    }
    
    /** Ajoute les unitées de jeu */
    private function addUnits(pGameData:GameData) : void
    {
      // Parcours des joueurs
      for each (var player:Player in pGameData.listPlayers)
      {
        // Parcours des unitées
        for each (var unit:UnitInstance in player.units)
        {
          var mv:MovieClip = Resources.getMovieClip(unit.unitId+"_"+Animations.LEFT);
          pGameData.layout.positionAndSize(mv, unit.x, unit.y);
          _layerUnits.addChild(mv);
        }
      }
    }

    /** Construit la tileMap */
    private function buildTileMap(pGameData:GameData) : void
    {
      // Ajoute toutes les tiles de fond
      var tilemap:TileMap = pGameData.tileMap;
      for each (var tile:Tile in tilemap.listTiles)
      {
        var texs:Vector.<Texture> = Resources.getTextures(tile.tileId);
        var rdTex:Texture = texs[uint(Math.random() * (texs.length-1))];
        // Crée une image pour le rendu de la tile
        var img:Image = new Image(rdTex);
        pGameData.layout.positionAndSize(img, tile.x, tile.y);
        _layerTileMap.addChild(img);
      }
    }
    
    /** Maj */
    public function update(pGameData:GameData) : void
    {
      // TODO
    }
  }
}