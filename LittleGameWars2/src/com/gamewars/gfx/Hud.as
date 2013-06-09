package com.gamewars.gfx
{
  import com.gamewars.components.GwImage;
  import com.gamewars.components.GwText;
  import com.gamewars.structures.Player;
  import com.gamewars.utils.Resources;
  
  import flashx.textLayout.formats.BackgroundColor;
  
  import starling.display.Image;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.text.TextField;
  
  public class Hud extends Sprite
  {
    /** Image du commander */
    private var mCoImage:Image;
    /** Background */
    private var mBg:Quad;
    /** Nom du joueur */
    private var mName:GwText;
    
    /** Constructeur */
    public function Hud()
    {
      super();
      
      mBg = new Quad(1,1, 0xffffff);
      addChild(mBg);
      mCoImage = new GwImage(Resources.emptyTex(1,1));
      addChild(mCoImage);
      mName = new GwText();
      addChild(mName);
      
      updateLayout();
    }
    
    /** Positionne correctement les éléments */
    private function updateLayout() : void
    {
      var gap:Number = 5;
      mBg.width = mBg.height = 1;
      mCoImage.x = gap;
      mCoImage.y = gap;
      mName.x = mCoImage.x + mCoImage.width + gap;
      mName.y = gap;
      mBg.width = width+gap;
      mBg.height = height+gap;
    }
    
    /** Définit le joueur pour lequel il faut afficher les infos */
    public function setInfo(pPlayer:Player) : void
    {
      mCoImage.texture = pPlayer.mCommander.mTex;
      mName.text = pPlayer.mCommander.mName;
      updateLayout();
    }
  }
}