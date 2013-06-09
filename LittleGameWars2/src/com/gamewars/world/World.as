package com.gamewars.world
{
  import com.gamewars.components.GwCursor;
  import com.gamewars.enums.GroundType;
  import com.gamewars.gfx.MovementGrid;
  import com.gamewars.structures.BaseEntity;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.TileMap;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.pathfinding.PathFinding;
  
  import flash.geom.Point;
  import flash.utils.Dictionary;
  
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  
  /**
  * Monde du jeu
  */
  public class World extends Sprite
  {
    /** Dimensions en tiles */
    public var mWidth:uint;
    public var mHeight:uint;
    
    /** Position de scroll */
    public var mScrollPosition:Point = new Point();
    /** Toutes les cellules du monde */
    private var mCells:Vector.<WorldCell> = new <WorldCell>[];
    /** Grille des mouvements */
    public var mMovementGrid:MovementGrid;
    /** Curseur */
    public var mCursor:GwCursor;
    /** Dictionnaire de tous les renderers */
    private var mRenderers:Dictionary = new Dictionary();
    
    /** Layers */
    private var mGroundLayer:Sprite;
    private var mStructureLayer:Sprite;
    private var mUnitLayer:Sprite;
    private var mTopLayer:Sprite;
    
    /** PathFinding */
    public var mPathFinding:PathFinding;
    
    /** Constructeur */
    public function World()
    {
      super();
      
      // Layers
      mGroundLayer = new Sprite();
      addChild(mGroundLayer);
      mStructureLayer = new Sprite();
      addChild(mStructureLayer);
      mUnitLayer = new Sprite();
      addChild(mUnitLayer);
      mTopLayer = new Sprite();
      addChild(mTopLayer);
      // Grille des mouvements
      mMovementGrid = new MovementGrid(this);
      mUnitLayer.addChild(mMovementGrid);
      // Curseur
      mCursor = new GwCursor();
      Starling.juggler.add(mCursor);
      mTopLayer.addChild(mCursor);
      // PathFinding
      mPathFinding = new PathFinding(this);
    }
    
    /** Retourne le renderer de l'entitée passée en paramètres */
    public function getEntityRenderer(pEntity:BaseEntity) : DisplayObject
    {
      return mRenderers[pEntity];
    }

    /** Recupère la cellule aux coordonnées spécifiées */
    public function getCellFromCoords(pX:Number, pY:Number) : WorldCell
    {
      if (!getBounds(null).contains(pX, pY))
        return null;
      
      return getCellAt(uint(pX/Tile.TILE_SIZE), uint(pY/Tile.TILE_SIZE));
    }
    
    /** Recupère la cellule aux coordonnées spécifiées */
    public function getCellFromPoint(pPoint:Point) : WorldCell
    {
      return getCellFromCoords(pPoint.x, pPoint.y);
    }
    
    /** Indique si la position est valide */
    public function isValidPosition(pX:uint, pY:uint) : Boolean
    {
      return pX < mWidth && pY < mHeight;
    }
    
    /** Définit la position du curseur */
    public function setCursorPosition(pX:uint, pY:uint) : void
    {
      if (!isValidPosition(pX, pY))
        throw new Error('Position de curseur invalide : ['+pX+','+pY+']');
      mCursor.x = pX * Tile.TILE_SIZE;
      mCursor.y = pY * Tile.TILE_SIZE;
    }
    
    /** Charge la map passée en paramètres */
    public function setMap(pMap:TileMap) : void
    {
      var xx:uint;
      var yy:uint;
      mWidth = pMap.mWidth;
      mHeight = pMap.mHeight;
      
      // Crée toutes les cellules du monde
      for (yy = 0; yy < pMap.mHeight; yy++)
      {
        for (xx = 0; xx < pMap.mWidth; xx++)
        {
          // Crée une cellule
          var cell:WorldCell = new WorldCell(this, xx, yy, GroundType.fromId(pMap.getGroundAt(xx, yy)));
          mCells.push(cell);
        }
      }
      
      // Crée tous les renderers
      for (yy = 0; yy < pMap.mHeight; yy++)
      {
        for (xx = 0; xx < pMap.mWidth; xx++)
        {
          mGroundLayer.addChild(getCellAt(xx, yy).createRenderer());
        }
      }
    }
    
    /** Ajoute une entitée au monde */
    public function addUnit(pUnit:Unit) : void
    {
      pUnit.setWorld(this);
      mUnitLayer.addChild(createRenderer(pUnit));
    }
    
    // TODO Manager de renderers/layers
    /** Ajoute un renderer pour l'unitée */
    private function createRenderer(pEntity:BaseEntity) : DisplayObject
    {
      var renderer:MovieClip = pEntity.createRenderer();
      renderer.x = pEntity.getCell().mX * Tile.TILE_SIZE;
      renderer.y = pEntity.getCell().mY * Tile.TILE_SIZE;
      mRenderers[pEntity] = renderer;
      Starling.juggler.add(renderer);
      return renderer
    }
    
    /** Ajoute une structure dans le monde */
    public function addStructure(pStructure:*) : void
    {
      // TODO Implementation
    }
    
    /** Renvoie la cellule aux coordonnées spécifiées */
    public function getCellAt(pX:int, pY:int) : WorldCell
    {
      // Coordonnées non valides
      if (pX < 0 || pX >= mWidth || pY < 0 || pY >= mHeight)
        return null;
      
      return mCells[pX+pY*mWidth];
    }
    
    /** Scroll vers la position définie */
    public function scrollTo(pX:Number, pY:Number) : void
    {
      mScrollPosition.setTo(pX, pY);
    }
    
    /** Maj de la map */
    public function update(pTimeDelta:Number) : void
    {
      // Scrolling
      var coords:Point = new Point(x, y);
      if (coords.subtract(mScrollPosition).length != 0)
      {
      }
      
      // Maj du curseur
      mCursor.advanceTime(pTimeDelta);
    }
  }
}