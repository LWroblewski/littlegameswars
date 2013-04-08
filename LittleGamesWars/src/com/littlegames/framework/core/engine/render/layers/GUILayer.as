package com.littlegames.framework.core.engine.render.layers
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.gui.listing.GUIUnitInfo;
  import com.littlegames.framework.entities.unit.UnitInstance;
  
  import starling.display.DisplayObject;
  import starling.display.Sprite;
  
  /**
  * Affichage de l'interface graphique
  * Gère l'interaction avec le joueur
  */
  public class GUILayer extends Sprite
  {
    /** Stockage des éléments graphique d'interface */
    private var _listGuiElements:Vector.<DisplayObject> = new <DisplayObject>[];
    // ------------------------------------------------------------------------
    /** Hud */
    private var _hud:Sprite;
    /** Informations d'unité */
    private var _unitInfo:GUIUnitInfo;
    
    /** Constructeur */
    public function GUILayer()
    {
      super();
      
      _hud = new Sprite();
      addChild(_hud);
      _unitInfo = new GUIUnitInfo();
      //addChild(_unitInfo);
      
      updateLayout();
    }
    
    /** Maj de la position des enfants */
    public function updateLayout() : void
    {
      _hud.x = 0;
      // TODO Un vrai layout en rapport avec les dims du parent
      _unitInfo.x = 200;
      _unitInfo.y = 200;
    }
    
    /** Maj */
    public function update(pGameData:GameData) : void
    {
      //var unitUnderCursor:UnitInstance = pGameData.getUnitUnderCursor();
      //_unitInfo.setUnit(unitUnderCursor);
    }
  }
}