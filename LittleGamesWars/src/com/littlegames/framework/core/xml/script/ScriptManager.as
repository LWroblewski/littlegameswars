package com.littlegames.framework.core.xml.script
{
  
  import com.littlegames.framework.core.xml.XMLLoader;
  
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  public class ScriptManager
  {
    private static var _scripts:Vector.<Script> = new Vector.<Script>;
    
    public static function loadScript(pPath:String):void
    {
      new XMLLoader(pPath, parseScripts).load()
    }
    
    public static function parseScripts(pXML:XML):void
    {
      if (pXML)
      {
        var script:Script;
        for each (var xmlScript:XML in pXML.children())
        {
          script = new Script();
          _scripts.push(script);
        }
      }
    }
  }
}