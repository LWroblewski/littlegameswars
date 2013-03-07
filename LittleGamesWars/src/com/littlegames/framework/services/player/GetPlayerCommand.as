package com.littlegames.framework.services.player
{
  import com.littlegames.framework.services.core.RemoteObjectCommand;
  
  public class GetPlayerCommand extends RemoteObjectCommand
  {
    public function GetPlayerCommand(pService:String, pOperation:String, pParameters:Object=null, pCallback:Function=null)
    {
      super(pService, pOperation, pParameters, pCallback);
    }
  }
}