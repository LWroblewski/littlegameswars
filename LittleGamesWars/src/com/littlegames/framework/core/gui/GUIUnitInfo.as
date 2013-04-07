package com.littlegames.framework.core.gui
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.text.TextField;
  import starling.textures.Texture;
  
  /** Gère l'affichage des informations d'unitées */
  public class GUIUnitInfo extends Sprite
  {
    /** Constructeur */
    public function GUIUnitInfo()
    {
      super();
      
      _background = new Image(Resources.emptyTexture);
      _unitType = new TextField(100, 24, 'Infantry');
      _hp = new TextField(50, 24, 'hp=10');
      _defense = new TextField(50, 24, 'def=1');
      _unitDisplay = new Image(Resources.emptyTexture);
      
      addChild(_background);
      addChild(_unitType);
      addChild(_hp);
      addChild(_defense);
      addChild(_unitDisplay);
      
      updateLayout();
    }
    
    /** Position les éléments */
    private function updateLayout() : void
    {
      _hp.x = 32;
      _hp.y = 24;
      _defense.x = 32;
      _defense.y = 48;
      _background.width = width;
      _background.height = height;
      _unitDisplay.y = 24;
    }
    
    /** Définit l'unitée pour laquelle on affiche les informations */
    public function setUnit(pUnitInstance:UnitInstance) : void
    {
      // TODO Crade, mettre un moyen de charger des textures directionelles par id
      _unitType.text = pUnitInstance.unit.name;
      var unitTex:Texture = Resources.getSingleTexture(pUnitInstance.unitId + '_' + Animations.LEFT);
      _unitDisplay.texture = unitTex;
      _unitDisplay.readjustSize();
      _hp.text = 'hp='+pUnitInstance.hp.toString();
      //_defense = pUnitInstance.
    }
    
    /** Maj */
    public function update(pGameData:GameData) : void
    {
      
    }
    
    // Elements graphiques
    // ------------------------------------------------------------------------
    /** Type de l'unitée */
    private var _unitType:TextField;
    /** Image de l'unitée */
    private var _unitDisplay:Image;
    /** Vie de l'unitée */
    private var _hp:TextField;
    /** Défense de l'unitée */
    private var _defense:TextField;
    /** Background */
    private var _background:Image;
  }
}