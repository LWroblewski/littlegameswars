package com.littlegames.framework.core.xml
{
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  public class XMLLoader
  {
    private var _path:String;
    
    private var _callback:Function;
    
    public function XMLLoader(pPath:String, pCallback:Function)
    {
      _path = pPath;
      _callback = pCallback;
      
      if (!_path || _callback == null)
      {
        throw new Error("Les paramètres path et callback sont obligatoires lors de l'instanciation d'un XMLLoader.");
      }
    }
    
    public function load():void
    {
      var loader:URLLoader = new URLLoader();
      loader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, onXMLLoaded);
      loader.load(new URLRequest(_path));
    }
    
    private function onXMLLoaded(pEvent:Event):void
    {
      var loader:URLLoader = pEvent.currentTarget as URLLoader;
      
      if (loader)
      {
        loader.removeEventListener(Event.COMPLETE, onXMLLoaded);
        
        try
        {
          _callback(new XML(loader.data));
        }
        catch (error:Error)
        {
          throw new Error("La callback du XMLLoader doit détenir un paramètre de type XML.");
        }
        
        loader = null;
      }
    }
  }
}