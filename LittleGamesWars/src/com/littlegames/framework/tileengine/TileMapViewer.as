package com.littlegames.framework.tileengine
{
  import com.littlegames.framework.resources.Textures;
  
  import flash.geom.Point;
  
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.textures.Texture;

  public class TileMapViewer extends Sprite
  {
    private static const TILE_PREFIX:String = 'Tile_';
    // ------------------------------------------------------------------------
    /** Zoom */
    private var _zoom:Number;
    /** Position du point haut gauche */
    private var _position:Point;
    /** TileMap */
    private var _tileMap:TileMap;
    
    /** Dimension des tiles */
    private var tileSideLenght:Number = 16;
    
    /** Indicateur de MAJ */
    private var _isDirty:Boolean = true;
    /** Liste des images composant la vue */
    private var _listImages:Vector.<Image>;
    
    /** Constructeur */
    public function TileMapViewer()
    {
      _position = new Point();
      _zoom = 1;
      _listImages = new <Image>[];
    }
    
    /** Définit la map affichée */
    public function setMap(pMap:TileMap) : void
    {
      _tileMap = pMap;
      _isDirty = true;
    }
    
    /** MAJ de la vue */
    public function update(pTimeDelta:Number) : void
    {
      if (_isDirty && _tileMap)
      {
        _isDirty = false;
        createImages();
      }
    }
    
    /** Crée toutes les images de tiles nécessaires */
    private function createImages() : void
    {
      // Vérifie si on a assez d'images pour toutes les tiles
      var toAdd:int = _tileMap.numTilesH * _tileMap.numTilesW;
      // Création des images
      var tileX:Number = 0;
      var tileY:Number = 0;
      while (toAdd-- > 0)
      {
        var img:Image = new Image(getTileTexture(0));
        img.width = img.height = tileSideLenght;
        img.x = tileX*tileSideLenght;
        img.y = tileY*tileSideLenght;
        addChild(img);
        tileX++;
        if (tileX > _tileMap.numTilesW)
        {
          tileX = 0;
          tileY++;
        }
      }
    }
    
    /** Retourne la texture de tile passée en paramètre */
    private function getTileTexture(pTileId:uint) : Texture
    {
      var result:Texture = Textures.textureAtlas.getTexture(TILE_PREFIX+pTileId);
      if (!result) throw new Error('Impossible de trouver la tile='+pTileId);
      return result;
    }
  }//end class
}//end package