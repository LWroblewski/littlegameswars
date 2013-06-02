package com.gamewars.screens
{
  import com.gamewars.GameWarsRoot;
  import com.gamewars.utils.Resources;
  
  import starling.display.Button;
  import starling.display.Sprite;
  import starling.events.Event;
  
  public class MainMenuScreen extends Sprite
  {
    /** Bouton escarmouche */
    private var mBtSkarmish:Button;
    
    /** Constructeur */
    public function MainMenuScreen()
    {
      super();

      // Bouton skirmish
      mBtSkarmish = new Button(Resources.getButtonTex(Resources.BT_SKARMISH));
      mBtSkarmish.addEventListener(Event.TRIGGERED, onBtSkarmishTriggered);
      addChild(mBtSkarmish);
    }
    
    /** Click sur le bouton skirmish */
    private function onBtSkarmishTriggered(pEvent:Event) : void
    {
      GameWarsRoot.getInstance().playSkirmish();
    }
  }
}