package com.gamewars.screens
{
  import com.gamewars.interfaces.IRender;
  
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.ResizeEvent;
  
  /** Classe de base des écrans du jeu. */
  public class BaseScreen extends Sprite
  {
    /** Eléments renderables gérés par le screen. */
    private var _renderables:Vector.<IRender>;
    
    public function BaseScreen()
    {
      super();
      
      _renderables = new Vector.<IRender>;
      
      addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }
    
    /** Initialisation d'un écran. */
    private function addedToStageHandler(pEvent:Event):void
    {
      removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
      
      addEventListener(Event.ENTER_FRAME, enterFrameHandler);
      
      initScreen();
    }
    
    /** Arrivée sur une nouvelle frame: nouveau cycle de rendu. */
    private function enterFrameHandler(pEvent:Event):void
    {
      for each (var renderable:IRender in _renderables)
      {
        renderable.renderElement();
      }
    }
    
    /** A surcharger si besoin pour initialisation de l'écran. */
    protected function initScreen():void
    {
      //To override if needed
    }
    
    /** Ajoute un élément dont le rendu sera géré par l'écran. */
    public function registerRenderable(pRenderable:IRender):void
    {
      if (_renderables.indexOf(pRenderable) == -1)
      {
        _renderables.push(pRenderable);
      }
    }
    
    /** Ajout à l'écran et dans la liste des éléments renderables. */
    public function addChildAsRenderable(pChild:IRender):void
    {
      if (pChild is DisplayObject)
      {
        addChild(pChild as DisplayObject);
        registerRenderable(pChild);
      }
    }
    
    /** Supprime un élément de la liste des objets renderables du screen. */
    public function unregisterRenderable(pRenderable:IRender):void
    {
      var itemIndex:int = _renderables.indexOf(pRenderable);
      if (itemIndex > -1)
      {
        _renderables.splice(itemIndex, 1);
      }
    }
    
    override public function dispose():void
    {
      
      super.dispose();
    }
  }
}