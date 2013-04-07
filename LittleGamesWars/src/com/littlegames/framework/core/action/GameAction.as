package com.littlegames.framework.core.action
{
  public class GameAction
  {
    /** Les types d'actions du jeu */
    public static const ACTION_MOVE:String = 'ACTION_MOVE';
    public static const ACTION_ATTACK:String = 'ACTION_ATTACK';
    public static const ACTION_CAPTURE:String = 'ACTION_CAPTURE';
    
    /** Type de l'action */
    public var actionType:String;
    
    /** Constructeur */
    public function GameAction(pType:String)
    {
    }
  }
}