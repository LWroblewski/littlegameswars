package com.gamewars.screens
{
  import com.gamewars.enums.CommanderType;
  import com.gamewars.enums.Commanders;
  import com.gamewars.resources.ResourceIds;
  import com.gamewars.resources.Resources;
  import com.gamewars.screens.components.MenuBackground;
  
  import starling.display.Image;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;

  /** Ecran de sélection du CO. */
  public class COSelectionScreen extends BaseScreen
  {
    private var _imgSelectedCO:Image;
    
    private var _selectedCO:CommanderType;
    
    protected function set selectedCO(pCO:CommanderType):void
    {
      if (_selectedCO != pCO)
      {
        _selectedCO = pCO;
        
        var texture:Texture = Resources.getSingleTexture(_selectedCO.name + ResourceIds.CO_BODY);
        if (!_imgSelectedCO)
        {
          _imgSelectedCO = new Image(texture);
          _imgSelectedCO.scaleX = _imgSelectedCO.scaleY = 2;
          addChild(_imgSelectedCO);
        } else {
          _imgSelectedCO.texture = texture;
        }
        _imgSelectedCO.y = stage.stageHeight - _imgSelectedCO.height; 
      }
    }
    
    protected function get selectedCO():CommanderType
    {
      return _selectedCO;
    }
    
    /** Constructeur. */
    public function COSelectionScreen()
    {
      super();
    }
    
    /** Initialisation de l'écran. */
    override protected function initScreen():void
    {
      addChildAsRenderable(new MenuBackground());
      
      var xIndex:Number = 0;
      for each (var co:CommanderType in Commanders.list)
      {
        var iconCO:Image = new Image(Resources.getSingleTexture(co.name + ResourceIds.CO_NEUTRAL));
        iconCO.addEventListener(TouchEvent.TOUCH, onIconCOTouch);
        iconCO.name = co.name;
        iconCO.x = xIndex;
        xIndex += iconCO.width;
        addChild(iconCO);
        
        if (!_selectedCO)
        {
          selectedCO = co;
        }
      }
    }
    
    private function onIconCOTouch(pEvent:TouchEvent):void
    {
      var touch:Touch = pEvent.getTouch(stage);
      if (touch && touch.phase == TouchPhase.ENDED)
      {
        var coName:String = (pEvent.target as Image).name;
        selectedCO = Commanders.getByName(coName);
      }
    }
  }
}