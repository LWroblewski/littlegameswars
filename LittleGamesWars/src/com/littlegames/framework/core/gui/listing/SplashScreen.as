package com.littlegames.framework.core.gui.listing
{
  import com.littlegames.framework.core.gui.BaseScreen;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.event.ChangeScreenEvent;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.ComponentUtils;
  import com.littlegames.framework.utils.Views;
  
  import starling.display.Button;
  import starling.events.Event;
  
  /** Ecran d'introduction */
  public class SplashScreen extends BaseScreen
  {
    private static const SPLASH_SCREEN:String = "splash-screen";
    
    private static const BTN_CAMPAIGN:String = "btn-campaign";
    
    override protected function initGameStage():void
    {
      initBackground();
      initButtons();
    }
    
    protected function initBackground():void
    {
      ComponentUtils.addImage(Resources.getSingleTexture(SPLASH_SCREEN));
    }
    
    protected function initButtons():void
    {
      ComponentUtils.addButton(Resources.getSingleTexture(BTN_CAMPAIGN), onBtnCampaignTriggered, -60, 300);
    }
    
    protected function onBtnCampaignTriggered(pEvent:Event):void
    {
      dispatchEvent(new ChangeScreenEvent(ChangeScreenEvent.CHANGE, Views.SCREEN_GAME));
    }
  }
}