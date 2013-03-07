package com.littlegames.framework.event
{
  import com.littlegames.framework.utils.Views;
  
  import starling.events.Event;
  
  /** Evénement dispatché lors d'une demande de changement de vue */
  public class ChangeScreenEvent extends Event
  {
    public static const CHANGE:String = "changeScreen";

    private var _screenId:String = Views.SCREEN_MAIN;

    public function get screenId():String
    {
      return _screenId;
    }

    public function ChangeScreenEvent(pType:String, pScreenId:String = Views.SCREEN_MAIN, pBubbles:Boolean = false)
    {
      super(pType, pBubbles);

      _screenId = pScreenId;
    }
  }
}
