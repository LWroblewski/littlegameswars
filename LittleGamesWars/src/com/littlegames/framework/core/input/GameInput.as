package com.littlegames.framework.core.input
{
  import com.littlegames.framework.core.engine.logic.GameEngine;
  
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
    private var _isMouseDown:Boolean = false;
    /** Touches clavier */
    private var _downKeys:Dictionary = new Dictionary();
    
    /** Constructeur */
    public function GameInput(pEngine:GameEngine)
    {
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
    }
    
    /** Gestion d'évenement souris */
    private function onMouseEvent(pEvent:MouseEvent) : void
    {
      if (pEvent.type == MouseEvent.MOUSE_DOWN)
        _isMouseDown = true;
      else if (pEvent.type == MouseEvent.MOUSE_UP)
        _isMouseDown = false;
      else if (pEvent.type == MouseEvent.MOUSE_MOVE)
      {
        _mousePosition.x = pEvent.stageX;
        _mousePosition.y = pEvent.stageY;
      }
    }
    
    /** Relache toutes les touches */
    public function releaseAll() : void
    {
      // Set toutes les clés à false
      for (var key:* in _downKeys)
      {
        _downKeys[key] = false;
      }
    }
    
    /** Retourne vrai si la touche est appuyée */
    public function isKeyDown(pKey:uint) : Boolean
    {
      return _downKeys[pKey] == true;
    }
    
    /** Récupère les coordonnées de la souris */
    public function getMousePosition() : Point
    {
      return _mousePosition;
    }
    
    /** Indique si on est en train de clicker */
    public function isMouseDown() : Boolean
    {
      return _isMouseDown;
    }
  }
}