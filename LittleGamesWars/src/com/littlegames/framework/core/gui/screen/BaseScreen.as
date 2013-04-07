package com.littlegames.framework.core.gui.screen
{
  import com.littlegames.framework.utils.Global;
  
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;
  
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.KeyboardEvent;

  /** Classe mère de tous les écrans */
  public class BaseScreen extends Sprite
  {
    /** Constructeur */
    public function BaseScreen()
    {
      super();
    }
    
    /** Maj de l'écran */
    public function update(pTimeDelta:Number) : void
    {
      // TO OVERRIDE
    }

    /** Nettoyage des ressources */
    override public function dispose():void
    {
      super.dispose();
    }
  }
}