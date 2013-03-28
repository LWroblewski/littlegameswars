package com.littlegames.framework.core
{
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;
  
  import starling.core.Starling;
  import starling.display.Sprite;
  import starling.events.TouchEvent;

  public class GameInput
  {
    /** Position de la souris */
    private var _mousePosition:Point = new Point();
    /** Touches clavier */
    private var _downKeys:Dictionary = new Dictionary();
    
    /** Constructeur */
    public function GameInput()
    {
      //Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
    
    /** Retourne vrai si la touche est appuyée */
    public function isKeyDown(pKey:uint) : Boolean
    {
      return _downKeys[pKey] == true;
    }
    
    /** Récupère les coordonnées de la souris */
    public function getMousePosition() : Point
    {
      _mousePosition.setTo(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
      return _mousePosition;
    }
  }
}