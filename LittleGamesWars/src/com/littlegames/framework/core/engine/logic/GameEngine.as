package com.littlegames.framework.core.engine.logic
{
  import com.littlegames.framework.core.GameComponent;
  import com.littlegames.framework.core.action.GameAction;
  import com.littlegames.framework.core.action.GameActionResult;
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.LevelConfiguration;
  import com.littlegames.framework.core.data.Player;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.RenderEngine;
  import com.littlegames.framework.core.engine.render.tileengine.Board;
  import com.littlegames.framework.core.engine.render.tileengine.TileMapGenerator;
  import com.littlegames.framework.core.gui.screen.BaseScreen;
  import com.littlegames.framework.core.input.GameInput;
  import com.littlegames.framework.entities.co.listing.Andy;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.entities.unit.Units;
  import com.littlegames.framework.resources.Resources;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Sprite;

  /**
  * Moteur de jeu client
  */
  public class GameEngine
  {
    /** Réference vers le composant de jeu */
    private var _gameComponent:GameComponent;
    // ------------------------------------------------------------------------
    private var _listEntities:Vector.<UnitInstance>;
    /** Unitée sélectionnée */
    private var _selectedUnit:UnitInstance;
    // ------------------------------------------------------------------------
    /** Dimensions de l'affichage */
    private var _displayWidth:Number;
    private var _displayHeight:Number;
    
    /** Moteur de gestion logique */
    private var _logicEngine:LogicEngine;
    /** Moteur de gestion du rendu */
    private var _renderEngine:RenderEngine;
    
    /** Constructeur */
    public function GameEngine(pRoot:GameComponent)
    {
      _gameComponent = pRoot;
      
      _logicEngine = new LogicEngine();
      _renderEngine = new RenderEngine();
      addChild(_renderEngine.renderLayer);
    }
    
    /** Ajoute un child au jeu */
    private function addChild(pSprite:DisplayObject) : void
    {
      _gameComponent.addChild(pSprite);
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
      
      var gameData:GameData = new GameData();
      gameData.tileMap = map;
      gameData.listPlayers.push(player);
      
      _logicEngine.initializeGame(gameData);
      _renderEngine.setGameData(gameData);
    }
    
    /** Maj du jeu */
    public function update(pTimeDelta:Number) : void
    {
      // Logic subsystem
      // ------------------------------------------------------------------------
      _logicEngine.update();
      
      // Transfert tous les messages chez le client
      while (_logicEngine.hasPendingResults())
      {
        var result:GameActionResult = _logicEngine.popResult();
        // TODO
      }
      
      // TODO Gestion des écrans
      //      Gestion des menus
      //      Gestion du jeu (tours/mouvements/fights)
      //      Gestion de l'UI
      
      // Render subsystem
      // ------------------------------------------------------------------------
      
      // MAJ de la map
      _renderEngine.update(pTimeDelta);
    }
    
  }//end class
}//end package