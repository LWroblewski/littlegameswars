package com.littlegames.framework.services.core
{
  import starling.events.Event;

  public class CommandEvent extends Event
  {
    public static const FINISH:String = 'finish';

    public static const CANCELED:String = 'canceled';

    protected var _result:Object;

    public function get result():Object
    {
      return _result;
    }

    public function CommandEvent(pType:String, pResult:Object)
    {
      super(pType, false);
      _result = pResult;
    }
  }
}