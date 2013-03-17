package com.littlegames.framework.stage
{
  import com.littlegames.framework.event.ChangeScreenEvent;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.ComponentUtils;
  import com.littlegames.framework.utils.Views;
  
  import starling.display.Button;
  import starling.events.Event;
  
  /** Ecran d'introduction */
  public class MainScreen extends BaseScreen
  {
    override protected function initGameStage():void
    {
      //Resources.add("InfantryWalkRight");
      //Resources.add("MechStandRight", 50, 50);
      initBackground();
      initButtons();
    }
    
    protected function initBackground():void
    {
      ComponentUtils.addImage(Resources.MAIN_SCREEN);
    }
    
    protected function initButtons():void
    {
      ComponentUtils.addButton(Resources.BTN_CAMPAIGN, onBtnCampaignTriggered, -90, 400);
    }
    
    protected function onBtnCampaignTriggered(pEvent:Event):void
    {
      dispatchEvent(new ChangeScreenEvent(ChangeScreenEvent.CHANGE, Views.SCREEN_GAME));
    }
  }
}