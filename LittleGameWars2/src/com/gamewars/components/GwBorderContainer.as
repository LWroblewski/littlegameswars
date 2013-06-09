package com.gamewars.components
{
  import starling.display.DisplayObject;
  import starling.display.Quad;
  import starling.display.Sprite;
  
  public class GwBorderContainer extends Sprite
  {
    /** Les backgrounds */
    private var mBorder:Quad;
    private var mBackground:Quad;
    /** Thickeness */
    private var mThickness:uint = 1;
    /** ContentGroup */
    private var mContentGroup:Sprite;
    /** Padding */
    private var mPadding:Number = 0;
    
    /** Constructeur */
    public function GwBorderContainer()
    {
      super();
      mBorder = new Quad(1,1,0);
      super.addChild(mBorder);
      mBackground = new Quad(1,1,0);
      super.addChild(mBackground);
      mContentGroup = new Sprite();
      super.addChild(mContentGroup);
    }
    
    /** @inheritDoc */
    override public function addChild(child:DisplayObject):DisplayObject
    {
      return mContentGroup.addChild(child);
    }
    
    /** Définit la couleur du bord */
    public function setBorderColor(pColor:uint) : void
    {
      mBorder.color = pColor;
    }
    
    /** Définit la couleur du fond */
    public function setBackgroundColor(pColor:uint) : void
    {
      mBackground.color = pColor;
    }
    
    /** Définition du padding */
    public function setPadding(pValue:Number) : void
    {
      mPadding = pValue;
    }
    
    /** Définit la taille de la bordure */
    public function setBorderThickness(pTickness:uint) : void
    {
      mThickness = pTickness;
    }
    
    /** Maj du layout */
    protected function updateLayout() : void
    {
      mContentGroup.x = mPadding + mThickness;
      mContentGroup.y = mPadding + mThickness;
      // Recalcule la taille des fonds
      mBackground.x = mThickness;
      mBackground.y = mThickness;
      mBackground.width = mContentGroup.width + mPadding*2;
      mBackground.height = mContentGroup.height + mPadding*2;
      mBorder.width = (mPadding+mThickness)*2+mContentGroup.width;
      mBorder.height = (mPadding+mThickness)*2+mContentGroup.height;
    }
  }
}