package com.gamewars.misc
{
  import com.gamewars.components.GwImage;
  import com.gamewars.structures.Player;
  import com.gamewars.utils.Resources;
  
  import starling.display.Image;
  import starling.display.Sprite;
  
  public class Hud extends Sprite
  {
    /** Image du commander */
    private var mCoImage:Image;
    
    /** Constructeur */
    public function Hud()
    {
      super();
      
      mCoImage = new GwImage(Resources.emptyTex(1,1));
      addChild(mCoImage);
      
      updateLayout();
    }
    
    /** Positionne correctement les éléments */
    private function updateLayout() : void
    {
      var gap:Number = 5;
      mCoImage.x = gap;
      mCoImage.y = gap;
    }
    
    /** Définit le joueur pour lequel il faut afficher les infos */
    public function setInfo(pPlayer:Player) : void
    {
      mCoImage.texture = pPlayer.mCommander.mTex;
    }
  }
}