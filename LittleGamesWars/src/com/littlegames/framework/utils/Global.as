package com.littlegames.framework.utils
{
  import com.littlegames.framework.core.data.Player;
  
  import starling.display.Sprite;
  import starling.display.Stage;

  public class Global
  {
    public static var stage:Stage;
    
    /** Vue actuelle */
    public static var currentScreen:Sprite;
    
    /** Liste des joueurs (dont le joueur physique + IAs) */
    public static var players:Vector.<Player>;
  }
}