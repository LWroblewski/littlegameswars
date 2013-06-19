package com.gamewars.core
{
  import com.gamewars.components.GwImage;
  import com.gamewars.enums.GroundType;
  import com.gamewars.gfx.enhancing.WaterTileEnhancer;
  import com.gamewars.interfaces.IRenderable;
  import com.gamewars.structures.Tile;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  import starling.display.Image;
  import starling.textures.RenderTexture;
  import starling.textures.Texture;

  public class RenderSystem
  {
    /** Liste des entitées affichées */
    private var mEntities:Dictionary = new Dictionary();
    /** Monde */
    private var mWorld:World;
    /** Rendu de la tilemap (Texture) */
    private var mTileMapTex:RenderTexture;
    /** Image du rendu de la tilemap */
    private var mTileMapImg:Image;
    
    /** Effectue le rendu du jeu */
    public function RenderSystem()
    {
    }
    
    /** Initialise le rendu du monde */
    public function initialize(pWorld:World) : void
    {
      mWorld = pWorld;
      
      // Creation d'une texture pour le rendu de la map
      var w:Number = pWorld.mWidth * Tile.TILE_SIZE;
      var h:Number = pWorld.mHeight * Tile.TILE_SIZE;
      
      // TODO Trouver un contournement aux limitations techniques de taille de texture
      if (w > 2048 && h > 2048) throw new Error('Impossible de rendre la map');
      
      mTileMapTex = new RenderTexture(w, h, false);
      mTileMapTex.drawBundled(renderMap);
      mTileMapImg = new Image(mTileMapTex);
      mWorld.mGroundLayer.addChild(mTileMapImg);
    }
    
    /** Dessine toutes les tiles */
    private function renderMap() : void
    {
      var img:GwImage = new GwImage(Resources.emptyTex(Tile.TILE_SIZE, Tile.TILE_SIZE));
      for each (var c:WorldCell in mWorld.mCells)
      {
        // Rendu spécial pour les terrains de type eau
        if (c.mGroundType == GroundType.WATER)
        {
          WaterTileEnhancer.render(c, mTileMapTex);
        }
        // Rendu des autres terrains
        else
        {
          img.texture = Resources.getTileTextures(c.mGroundType.mTexPrefix)[0];
          img.x = c.mPosition.xOffset;
          img.y = c.mPosition.yOffset;
          mTileMapTex.draw(img);
        }
      }
    }
    
    /** Ajoute un élément de rendu */
    public function add(pRenderable:IRenderable) : void
    {
      
    }
  }
}