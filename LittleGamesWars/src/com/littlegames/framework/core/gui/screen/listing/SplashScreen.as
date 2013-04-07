package com.littlegames.framework.core.gui.screen.listing
{
  import com.littlegames.framework.core.gui.screen.BaseScreen;
  
  import starling.display.Image;
  import starling.events.TouchEvent;
  import starling.textures.Texture;
  
  public class SplashScreen extends BaseScreen
  {
    /** SplashScreen */
    // TODO Export
    [Embed(source="assets/menu/btnCampaign.png")]
    private var bgSplashScreen:Class;
    
    /** Constructeur */
    public function SplashScreen()
    {
      super();
      
      var bg:Image = new Image(Texture.fromBitmap(new bgSplashScreen(), false, true));
      addChild(bg);
      
      // TODO Export?
      addEventListener(TouchEvent.TOUCH, onTouch);
    }
    
    /** Gestion du touch */
    private function onTouch(pEvent:TouchEvent) : void
    {
      trace('okez');
    }
    
    /** @inheritDoc */
    override public function update(pTimeDelta:Number) : void
    {
      super.update(pTimeDelta);
    }
  }
}