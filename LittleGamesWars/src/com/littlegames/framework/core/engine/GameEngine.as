package com.littlegames.framework.core.engine
{
  import com.littlegames.framework.core.GameComponent;
  import com.littlegames.framework.core.engine.tileengine.Board;
  import com.littlegames.framework.core.engine.tileengine.TileMap;
  import com.littlegames.framework.core.gui.BaseScreen;
  import com.littlegames.framework.core.input.GameInput;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.entities.unit.listing.Infantry;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.resources.TextureManager;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Sprite;

  /** 
  * Moteur principal du jeu 
  * Gère :
  * - Les changements d'écrans
  * - Clavier/Souris
  */
  public class GameEngine
  {
    /** Réference vers le composant de jeu */
    private var _gameComponent:GameComponent;
    // ------------------------------------------------------------------------
    /** Réference vers le viewer de map */
    private var _board:Board;
    /** Entrée de jeu */
    private var _gameInput:GameInput;
    /** Ecran en cours d'affichage */
    private var _currentScreen:BaseScreen;
    // ------------------------------------------------------------------------
    private var _listEntities:Vector.<UnitInstance>;
    /** Unitée sélectionnée */
    private var _selectedUnit:UnitInstance;
    
    /** Constructeur */
    public function GameEngine(pRoot:GameComponent)
    {
      _gameComponent = pRoot;
      
      _board = new Board();
      addChild(_board);
      
      _gameInput = new GameInput(this);
    }
    
    /** Ajoute un child au jeu */
    private function addChild(pSprite:DisplayObject) : void
    {
      _gameComponent.addChild(pSprite);
    }
    
    /** Lance le jeu */
    public function initializeGame(pMap:TileMap) : void
    {
      _board.setMap(pMap);
      
      // Ajout des unitées
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 10, 10, true));
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 11, 10, true));
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 12, 10, true));
      
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 10, 3, true));
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 11, 3, true));
      _board.addUnit(new UnitInstance(new Infantry(), UnitInstance.MAX_HP, 12, 3, true));
    }
    
    /** Maj du jeu */
    public function update(pTimeDelta:Number) : void
    {
      // TODO Gestion des écrans
      //      Gestion des menus
      //      Gestion du jeu (tours/mouvements/fights)
      //      Gestion de l'UI
      
      // MAJ de la map
      _board.update(pTimeDelta);
    }
    
    /** Retourne l'unitée sélectionnée */
    private function getUnitUnderMouse() : UnitInstance
    {
      // TODO
      return null;
    }
    
  }//end class
}//end package