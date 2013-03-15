package com.littlegames.framework.stage
{
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.ComponentUtils;
  
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
      ComponentUtils.addImage(null);
    }
    
    protected function initButtons():void
    {
      ComponentUtils.addButton(Resources.BTN_CAMPAIGN, onBtnCampaignTriggered, -50, 200);
    }
    
    protected function onBtnCampaignTriggered(pEvent:Event):void
    {
      
    }
  }
}