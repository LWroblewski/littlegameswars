package com.littlegames.framework.core.engine.logic
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.LevelConfiguration;
  import com.littlegames.framework.core.data.Player;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.data.TilePosition;
  import com.littlegames.framework.core.engine.render.layers.GUILayer;
  import com.littlegames.framework.core.engine.render.layers.MapLayer;
  import com.littlegames.framework.core.engine.render.tileengine.TileMapGenerator;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.entities.co.listing.Andy;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.entities.unit.Units;
  import com.littlegames.framework.resources.Resources;
  
  import flash.events.MouseEvent;
  import flash.geom.Point;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.Sprite;

  /** Vue de jeu */
  public class GameView extends Sprite
  {
    // ------------------------------------------------------------------------
    // Etats de jeu
    // ------------------------------------------------------------------------
    /** Unitée sélectionnée */
    private const STATE_UNIT_SELECTION:String = 'STATE_UNIT_SELECTION';
    /** Action sélectionnée */
    private const STATE_ACTION_SELECTION:String = 'STATE_ACTION_SELECTION';
    /** Cible sélectionnée */
    private const STATE_TARGET_SELECTION:String = 'STATE_TARGET_SELECTION';
    
    /** Zone de rendu du jeu */
    private var _mapLayer:MapLayer;
    /** Zone de rendu de l'interface graphique */
    private var _guiLayer:GUILayer;
    /** Gestion du curseur */
    private var _cursor:Image;
    // ------------------------------------------------------------------------
    /** Données du jeu */
    private var _gameData:GameData;
    // ------------------------------------------------------------------------
    /** L'unitée selectionnée */
    private var _selectedUnit:UnitInstance = null;
    /** Action selectionnée */
    private var _selectedAction:String = null;
    /** Cible sélectionnée */
    private var _selectedEnnemyTarget:UnitInstance;
    /** Destination selectionnée */
    private var _selectedDestination:Tile;
    /** Etat du jeu */
    private var _currentState:String = STATE_UNIT_SELECTION;
    
    /** Constructeur */
    public function GameView()
    {
      _mapLayer = new MapLayer();
      _guiLayer = new GUILayer();
      _cursor = Resources.getImage("cursor");
      
      addChild(_mapLayer);
      addChild(_guiLayer);
      addChild(_cursor);
      
      //Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, onTouch);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
    }
    
    /** Lance le jeu */
    public function initializeGame(pGameConfiguration:LevelConfiguration) : void
    {
      var map:TileMap = new TileMap(80, 40);
      new TileMapGenerator().generate(map);
      
      var player:Player = new Player('Susmonski', new Andy(), 0);
      player.units.push(new UnitInstance(Units.INFANTRY, UnitInstance.MAX_HP, 10, 10, true));
      player.units.push(new UnitInstance(Units.MECH, UnitInstance.MAX_HP, 11, 10, true));
      player.units.push(new UnitInstance(Units.TANK, UnitInstance.MAX_HP, 12, 10, true));
          
      player.units.push(new UnitInstance(Units.WAR_TANK, UnitInstance.MAX_HP, 10, 3, true));
      player.units.push(new UnitInstance(Units.ARTILLERY, UnitInstance.MAX_HP, 11, 3, true));
      player.units.push(new UnitInstance(Units.ANTI_AIR, UnitInstance.MAX_HP, 12, 3, true));
      
      _gameData = new GameData();
      _gameData.tileMap = map;
      _gameData.listPlayers.push(player);
      
      _mapLayer.initialize(_gameData);
    }
    
    /** Réinitialize la vue */
    private function rebuildView() : void
    {
      _mapLayer.initialize(_gameData);
    }
    
    /** Maj du jeu */
    public function update(pTimeDelta:Number) : void
    {
      _gameData.ellapsedTime = pTimeDelta;
      _mapLayer.update();
      _guiLayer.update();
      
      // Gestion d'une unitée sélectionnée
      if (isStateComplete())
        processNextStep();
    }
    
    /** Permet de savoir si on a toutes les informations nécessaire de l'état de jeu */
    private function isStateComplete() : Boolean
    {
      // Free
      if (_currentState == STATE_UNIT_SELECTION && _selectedUnit)
        return true;
      else if (_currentState == STATE_ACTION_SELECTION && _selectedAction)
        return true;
      else if (_currentState == STATE_TARGET_SELECTION && _selectedEnnemyTarget)
        return true;
      
      return false;
    }
    
    /** Effectue les actions necessaires pour passer à l'état suivant */
    private function processNextStep() : void
    {
      // TODO Effectuer les transitions d'états (affichage de menu/déplacements/etc...)
    }
    
    // ------------------------------------------------------------------------
    // Gestion de la souris
    // ------------------------------------------------------------------------
    private var _mouseIsDown:Boolean = false;
    private var _mouseDownPosition:Point = new Point();
    private var _initialScrollPosition:Point;
    /** Gestion de la souris */
    private function onMouseEvent(pEvent:MouseEvent) : void
    {
      if (pEvent.type == MouseEvent.MOUSE_DOWN)
      {
        _mouseIsDown = true;
        _mouseDownPosition.setTo(pEvent.stageX, pEvent.stageY);
      }
      else if (pEvent.type == MouseEvent.MOUSE_UP)
      {
        _mouseIsDown = false;
        _mapLayer.setLocalCursorPosition(pEvent.stageX, pEvent.stageY);
        _selectedUnit = _mapLayer.getUnitUnderCursor();
      }
      else if (pEvent.type == MouseEvent.MOUSE_MOVE && _mouseIsDown)
      {
        var deltaX:Number= _mouseDownPosition.x - pEvent.stageX;
        var deltaY:Number = _mouseDownPosition.y - pEvent.stageY;
        _mouseDownPosition.setTo(pEvent.stageX, pEvent.stageY);
        if (deltaX != 0 || deltaY != 0)
        {
          _mapLayer.scroll(deltaX, deltaY);
        }
      }
    }
    
  }//end class
}//end package