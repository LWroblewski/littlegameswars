package com.littlegames.framework.core.engine.render.layers
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.engine.render.ActionMenu;
  import com.littlegames.framework.core.gui.listing.GUIUnitInfo;
  import com.littlegames.framework.entities.unit.UnitInstance;
  
  import flash.geom.Point;
  
  import starling.display.DisplayObject;
  import starling.display.Sprite;
  
  /** Affichage de l'interface graphique */
  public class GUILayer extends Sprite
  {
    /** Hud */
    private var _hud:Sprite;
    /** Informations d'unité */
    private var _unitInfo:GUIUnitInfo;
    /** Menu d'actions */
    private var _actionMenu:ActionMenu;
    
    /** Constructeur */
    public function GUILayer()
    {
      super();
      
      _hud = new Sprite();
      _actionMenu = new ActionMenu();
      _unitInfo = new GUIUnitInfo();
      
      addChild(_hud);
      addChild(_actionMenu);
      //addChild(_unitInfo);
      
      updateLayout();
    }
    
    /** Définit la callback utilisé lors de la selection d'une action */
    public function setActionCallback(pFunction:Function) : void
    {
      _actionMenu.actionCallback = pFunction;
    }
    
    /** Maj de la position des enfants */
    public function updateLayout() : void
    {
      _hud.x = 0;
      // TODO Un vrai layout en rapport avec les dims du parent
      _unitInfo.x = 200;
      _unitInfo.y = 200;
    }
    
    /** Cache le menu d'action */
    public function hideActionMenu() : void
    {
      _actionMenu.visible = false;
    }
    
    /** Affiche le menu */
    public function displayActionMenu(pItems:Vector.<String>, pPosition:Point) : void
    {
      _actionMenu.visible = true;
      _actionMenu.displayItems(pItems);
      _actionMenu.x = pPosition.x;
      _actionMenu.y = pPosition.y;
    }
    
    /** Maj */
    public function update() : void
    {
      //var unitUnderCursor:UnitInstance = pGameData.getUnitUnderCursor();
      //_unitInfo.setUnit(unitUnderCursor);
    }
  }
}