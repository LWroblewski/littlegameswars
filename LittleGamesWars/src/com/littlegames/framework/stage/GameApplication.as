package com.littlegames.framework.stage
{
  import com.littlegames.framework.core.GameComponent;
  
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.geom.Rectangle;
  
  import starling.core.Starling;
  import starling.events.ResizeEvent;
  
  /** Classe de base des applications de chaque niveau de la campagne */
  public class GameApplication extends Sprite
  {
    /** Moteur de rendu du jeu. */
    protected var _starling:Starling = null;

    /** Constructeur de l'application */
    public function GameApplication(pDefaultStage:Class = null)
    {
      super();
      
      // These settings are recommended to avoid problems with touch handling
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;
      
      if ((stage.stageWidth != 0) && (stage.stageHeight != 0))
      {
        init();
      }
      else
      {
        //work around IE flash embedding issues
        stage.addEventListener(Event.RESIZE, onResize);
      }
    }
    
    /** Redimension */
    private function onResize(e:Event):void
    {
      if ((stage.stageWidth != 0) && (stage.stageHeight != 0))
      {
        stage.removeEventListener(Event.RESIZE, onResize);
        init();
      }
    }
    
    /** Initialisation */
    private function init():void
    {
      _starling = new Starling(GameComponent, stage, new Rectangle(0,0,500,375));
      _starling.start();
      
      //Starling.current.stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
    }
    
    /** Redimension du stage */
    private function resizeStage(event:ResizeEvent):void
    {
      // set rectangle dimensions for viewPort:
      var viewPortRectangle:Rectangle = new Rectangle();
      
      viewPortRectangle.width = event.width;
      viewPortRectangle.height = event.height;
      
      // resize the viewport:
      _starling.viewPort = viewPortRectangle;
      
      // assign the new stage width and height:
      //mStarling.stage.stageWidth = event.width;
      //mStarling.stage.stageHeight = event.height;
    }
  }
}