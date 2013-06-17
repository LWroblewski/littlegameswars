package com.gamewars.gfx
{
  import com.gamewars.components.GwBorderContainer;
  import com.gamewars.components.GwImage;
  import com.gamewars.components.GwText;
  import com.gamewars.enums.Textures;
  import com.gamewars.structures.Player;
  import com.gamewars.utils.Resources;
  
  import flashx.textLayout.formats.BackgroundColor;
  
  import starling.display.Image;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.text.TextField;
  
  public class Hud extends GwBorderContainer
  {
    /** Image du commander */
    private var mCoImage:Image;
    /** Nom du joueur */
    private var mName:GwText;
    
    /** Constructeur */
    public function Hud()
    {
      super();
      
      mCoImage = new GwImage(Resources.emptyTex(1,1));
      addChild(mCoImage);
      mName = new GwText();
      addChild(mName);
      
      setBorderThickness(2);
      setPadding(5);
      setBorderColor(0);
      setBackgroundColor(0xffffff);
    }
    
    /** @inheritDoc */
    override protected function updateLayout() : void
    {
      mName.x = mCoImage.x + mCoImage.width + 5;
      super.updateLayout();
    }
    
    /** Définit le joueur pour lequel il faut afficher les infos */
    public function setInfo(pPlayer:Player) : void
    {
      mCoImage.texture = pPlayer.mCommander.getTexture(Textures.HEAD_NEUTRAL);
      mName.text = pPlayer.mCommander.name;
      updateLayout();
    }
  }
}