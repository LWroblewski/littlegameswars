package com.gamewars.world
{
  import com.gamewars.components.GwCursor;
  import com.gamewars.enums.GroundType;
  import com.gamewars.gfx.MovementGrid;
  import com.gamewars.managers.FogManager;
  import com.gamewars.structures.BaseEntity;
  import com.gamewars.structures.Player;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.TileMap;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.TilePoint;
  import com.gamewars.utils.pathfinding.PathFinding;
  
  import flash.geom.Point;
  import flash.geom.Rectangle;
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
    public var mCells:Vector.<WorldCell> = new <WorldCell>[];
    /** Grille des mouvements */
    public var mMovementGrid:MovementGrid;
    /** Curseur */
    public var mCursor:GwCursor;
    /** Dictionnaire de tous les renderers */
    private var mRenderers:Dictionary = new Dictionary();
    
    /** Layers */
    public var mGroundLayer:Sprite;
    private var mStructureLayer:Sprite;
    public var mFogLayer:Sprite; // public for GameEngine
    private var mUnitLayer:Sprite;
    private var mTopLayer:Sprite;
    
    /** PathFinding */
    public var mPathFinding:PathFinding;
    /** Liste des joueurs */
    public var mPlayers:Vector.<Player> = new <Player>[];
    /** Tilemap */
    private var mTileMap:TileMap;
    
    /** Constructeur */
    public function World(pTileMap:TileMap)
    {
      super();
      
      mTileMap = pTileMap;
      mWidth = pTileMap.mWidth;
      mHeight = pTileMap.mHeight;
      build();
      
      // Layers
      mGroundLayer = new Sprite(); // Sol
      addChild(mGroundLayer);
      mStructureLayer = new Sprite(); // Structure
      addChild(mStructureLayer);
      mFogLayer = new Sprite(); // Brouillard
      addChild(mFogLayer);
      mUnitLayer = new Sprite(); // Unités
      addChild(mUnitLayer);
      mTopLayer = new Sprite(); // Top
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
      if (pX < 0 || pX >= width || pY < 0 || pY >= height)
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
    public function build() : void
    {
      var xx:uint;
      var yy:uint;
      
      // Crée toutes les cellules du monde
      for (yy = 0; yy < mHeight; yy++)
      {
        for (xx = 0; xx < mWidth; xx++)
        {
          // Crée une cellule
          var cell:WorldCell = new WorldCell(this, xx, yy, GroundType.fromId(mTileMap.getGroundAt(xx, yy)));
          mCells.push(cell);
        }
      }
    }
    
    /** Ajoute une entitée au monde */
    public function addUnit(pUnit:Unit) : void
    {
      pUnit.setWorld(this);
      mUnitLayer.addChild(createRenderer(pUnit));
    }
    
    /** Enlève l'unitée du monde */
    public function removeUnit(pUnit:Unit) : void
    {
      mUnitLayer.removeChild(mRenderers[pUnit]);
    }
    
    /** Ajoute un joueur au monde */
    public function addPlayer(pPlayer:Player) : void
    {
      if (mPlayers.indexOf(pPlayer) != -1) throw new Error('Player already added');
      mPlayers.push(pPlayer);
      // Ajout des unitées
      for each (var unit:Unit in pPlayer.mUnits)
      {
        addUnit(unit);
      }
    }
    
    // TODO Manager de renderers/layers
    /** Ajoute un renderer pour l'unitée */
    private function createRenderer(pEntity:Unit) : DisplayObject
    {
      var renderer:MovieClip = pEntity.createRenderer();
      renderer.x = pEntity.getCell().mPosition.xOffset;
      renderer.y = pEntity.getCell().mPosition.yOffset;
      mRenderers[pEntity] = renderer;
      Starling.juggler.add(renderer);
      return renderer
    }
    
    /** Ajoute une structure dans le monde */
    public function addStructure(pStructure:*) : void
    {
      // TODO Implementation
    }
    
    /** Retourne tous les ennemis du joueur */
    public function getOpponents(pPlayer:Player) : Vector.<Player>
    {
      var result:Vector.<Player> = new <Player>[];
      for each (var pl:Player in mPlayers)
      {
        // TODO Test de teams
        if (pl != pPlayer)
          result.push(pl);
      }
      return result;
    }
    
    /** Retourne la cellule aux coordonnées spécifiées */
    public function getCellAt(pX:int, pY:int) : WorldCell
    {
      // Coordonnées non valides
      if (pX < 0 || pX >= mWidth || pY < 0 || pY >= mHeight)
        return null;
      
      return mCells[pX+pY*mWidth];
    }
    
    /** Retourne la cellule aux coordonnées spécifiées */
    public function getCellAtPoint(pPoint:TilePoint) : WorldCell
    {
      return getCellAt(pPoint.tileX, pPoint.tileY);
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
      if (mScrollPosition.x > width-Starling.current.stage.stageWidth/2) mScrollPosition.x = width-Starling.current.stage.stageWidth/2;
      if (mScrollPosition.x < -Starling.current.stage.stageWidth/2) mScrollPosition.x = -Starling.current.stage.stageWidth/2;
      if (mScrollPosition.y > height-Starling.current.stage.stageHeight/2) mScrollPosition.y = height-Starling.current.stage.stageHeight/2;
      if (mScrollPosition.y < -Starling.current.stage.stageHeight/2) mScrollPosition.y = -Starling.current.stage.stageHeight/2;
      x = -mScrollPosition.x;
      y = -mScrollPosition.y;
      
      // Maj du curseur
      mCursor.advanceTime(pTimeDelta);
    }
  }
}