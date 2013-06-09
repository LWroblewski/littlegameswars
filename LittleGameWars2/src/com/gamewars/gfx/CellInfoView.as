package com.gamewars.gfx
{
  import com.gamewars.components.GwBorderContainer;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.WorldCell;
  
  import starling.display.Quad;
  import starling.display.Sprite;
  
  public class CellInfoView extends GwBorderContainer
  {
    /** Information de terrain */
    private var mTileInfoPart:TileInfoPart;
    /** Informations d'unité */
    private var mUnitInfoPart:UnitInfoPart;
    /** Arrière plan */
    private var mBackground:Quad;
    
    /** Informations de tile */
    public function CellInfoView()
    {
      super();
      
      mBackground = new Quad(1,1,0x999999);
      addChild(mBackground);
      mTileInfoPart = new TileInfoPart();
      addChild(mTileInfoPart);
      mUnitInfoPart = new UnitInfoPart();
      addChild(mUnitInfoPart);
      
      setBorderThickness(2);
      setPadding(5);
      setBorderColor(0);
      setBackgroundColor(0xffffff);
    }
    
    /** Maj du layout */
    override protected function updateLayout() : void
    {
      mTileInfoPart.y = mUnitInfoPart.y + (mUnitInfoPart.visible?mUnitInfoPart.height:0);
      super.updateLayout();
    }
    
    /** Affiche les informations de la tile passée en paramètres */
    public function setCellInfo(pCell:WorldCell) : void
    {
      if (pCell == null)
      {
        return;
      }
      
      // Délegation
      mTileInfoPart.displayInfo(pCell);
      if (pCell.getUnit() != null)
      {
        mUnitInfoPart.displayInfo(pCell.getUnit());
        mUnitInfoPart.visible = true;
      }
      else
      {
        mUnitInfoPart.visible = false;
      }
      
      updateLayout();
    }
  }
}

// ------------------------------------------------------------------------
// Partie d'information de tile
// ------------------------------------------------------------------------
import com.gamewars.components.GwImage;
import com.gamewars.components.GwText;
import com.gamewars.structures.Unit;
import com.gamewars.utils.Resources;
import com.gamewars.world.WorldCell;

import starling.display.Sprite;
import starling.textures.Texture;

class TileInfoPart extends Sprite
{
  /** Informations tile */
  private var mTileRender:GwImage;
  private var mTileName:GwText;
  private var mStars:Vector.<GwImage>=new <GwImage>[];
  
  public function TileInfoPart() 
  {
    var emptyTex:Texture = Texture.empty(32,32);
    mTileRender = new GwImage(emptyTex);
    addChild(mTileRender);
    mTileName = new GwText();
    addChild(mTileName);
    for (var i:uint = 0; i < 5; i++)
    {
      var starImg:GwImage = new GwImage(Resources.getGuiTex('Star_0'));
      addChild(starImg);
      mStars.push(starImg);
    }
  }
  
  /** Affichage des étoiles de défense */
  private function activateStars(pValue:uint) : void
  {
    for (var i:uint = 0; i < 5; i++)
    {
      mStars[i].texture = (i+1 <= pValue)?Resources.getGuiTex('Star_0'):Resources.getGuiTex('Star_1');
    }
  }
  
  /** Maj du layout */
  private function updateLayout() : void
  {
    var gap:Number = 5;
    mTileRender.x = 0;
    mTileRender.y = 0;
    mTileName.x = mTileRender.x + mTileRender.width + gap;
    
    var starsGap:Number = 2;
    for (var i:uint = 0; i < mStars.length; i++)
    {
      mStars[i].x = i * mStars[i].width + (i>0?starsGap:0);
      mStars[i].y = mTileRender.y + mTileRender.height + gap;
    }
  }
  
  /** Affiche les informations de tile */
  public function displayInfo(pCell:WorldCell) : void
  {
    // Informations de tile
    mTileRender.texture = Resources.getTileTextures(pCell.mGroundType.mTexPrefix)[0];
    mTileName.text = pCell.mGroundType.mName;
    activateStars(pCell.mGroundType.mDefense);
    updateLayout();
  }
}

// ------------------------------------------------------------------------
// Partie d'information d'unité
// ------------------------------------------------------------------------

class UnitInfoPart extends Sprite
{
  /** Informations unitée */
  private var mUnitRender:GwImage;
  private var mUnitName:GwText;
  private var mLifeImage:GwImage;
  private var mLifeValue:GwText;
  private var mFuelImage:GwImage;
  private var mFuelValue:GwText;
  private var mAmmoImage:GwImage;
  private var mAmmoValue:GwText;
  
  public function UnitInfoPart()
  {
    var emptyTex:Texture = Texture.empty(32,32);
    mUnitRender = new GwImage(emptyTex);
    addChild(mUnitRender);
    mUnitName = new GwText();
    addChild(mUnitName);
    mLifeImage = new GwImage(Resources.getGuiTex('Heart'));
    addChild(mLifeImage);
    mLifeValue = new GwText();
    addChild(mLifeValue);
    mFuelImage = new GwImage(Resources.getGuiTex('Fuel'));
    addChild(mFuelImage);
    mFuelValue = new GwText();
    addChild(mFuelValue);
    mAmmoImage = new GwImage(Resources.getGuiTex('Ammo'));
    addChild(mAmmoImage);
    mAmmoValue = new GwText();
    addChild(mAmmoValue);
    
    updateLayout();
  }
  
  private function updateLayout() : void
  {
    var gap:Number = 5;
    mUnitRender.x = 0;
    mUnitRender.y = 0;
    mUnitName.y = 0;
    mUnitName.x = mUnitRender.x + mUnitRender.width + gap;
    mLifeImage.y = mLifeValue.y = mFuelImage.y = mFuelValue.y = mAmmoImage.y = mAmmoValue.y = mUnitRender.y + mUnitRender.height + gap;
    mLifeValue.x = mLifeImage.x + mLifeImage.width + gap;
    mFuelImage.x = mLifeValue.x + mLifeValue.width + gap;
    mFuelValue.x = mFuelImage.x + mFuelImage.width + gap;
    mAmmoImage.x = mFuelValue.x + mFuelValue.width + gap;
    mAmmoValue.x = mAmmoImage.x + mAmmoImage.width + gap;
  }
  
  /** Affiche les informations de l'unité */
  public function displayInfo(pUnit:Unit) : void
  {
    mUnitRender.texture = pUnit.getRenderTex();
    mUnitName.text = pUnit.mUnitType.mName;
    mLifeValue.text = pUnit.mHp.toString();
    mFuelValue.text = pUnit.mFuel.toString();
    mAmmoValue.text = pUnit.mAmmo.toString();
    updateLayout();
  }
}