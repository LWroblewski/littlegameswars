package com.littlegames.framework.core.engine.render
{
  import com.littlegames.framework.resources.Resources;
  
  import flash.geom.Rectangle;
  
  import starling.display.Button;
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.textures.Texture;
  
  public class ActionMenu extends Sprite
  {
    /** Changement de la taille du menu */
    private var _sizeChanged:Boolean = false;
    /** Méthode appelée sur selection d'un élément */
    public var actionCallback:Function = null;
    
    /** Menu d'action */
    public function ActionMenu()
    {
      super();
      
      _background = new Image(Resources.emptyTexture);
      addChild(_background);
    }
    
    /** Affiche les items passés en paramètres dans le menu */
    public function displayItems(pListItems:Vector.<String>) : void
    {
      var len:uint = pListItems.length;
      for (var i:uint = 0; i < len; i++)
      {
        var bt:Button = null;
        var item:String = pListItems[i];
        if (_listButtons.length == i)
        {
          _sizeChanged = true;
          bt = new Button(Texture.empty(100, 32), 'WWWWWWWWWWWWWWW');
          bt.y = i * 32;
          bt.addEventListener(Event.TRIGGERED, onButtonTriggered);
          _listButtons.push(bt);
          addChild(bt);
        }
        else
        {
          bt = _listButtons[i];
          bt.visible = true;
        }
        
        bt.text = item;
        _sizeChanged = true;
      }
      
      _background.width = width;
      _background.height = height;
    }
    
    /** Click sur un bouton */
    private function onButtonTriggered(pEvent:Event) : void
    {
      var target:Button = Button(pEvent.target);
      
      if (actionCallback != null)
      {
        actionCallback(target.text);
      }
    }
    
    /** Arrière plan du menu */
    private var _background:Image;
    /** Liste des boutons du menu */
    private var _listButtons:Vector.<Button> = new <Button>[];
  }
}