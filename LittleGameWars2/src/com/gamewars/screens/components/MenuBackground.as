package com.gamewars.screens.components
{
  import flash.display.Bitmap;
  import flash.geom.Point;
  
  import starling.display.Image;
  import starling.events.EnterFrameEvent;
  import starling.events.Event;
  import starling.textures.Texture;
  import starling.textures.TextureSmoothing;

  public class MenuBackground extends Image 
  {
    /** Texture par défaut du fond */
    [Embed(source = "resources/menu_background.png")]
    private static const _MENU_BACKGROUND:Class;
    
    /** Réference vers la texture */
    private var mTexture:Texture;
    /** Compteur de temps */
    private var mPassedTime:Number = 0;
    /** Vitesse de déplacement de la texture */
    private var mDisplacementSpeed:Number = 0.4;
    /** Scale de la texture */
    private var mTextureScale:Point = new Point();

    public function MenuBackground(pBitmap:Bitmap = null)
    {
      if (!pBitmap)
        pBitmap = new _MENU_BACKGROUND as Bitmap;
      // Chargement en VRAM de la texture
      mTexture = Texture.fromBitmap(pBitmap);
      mTexture.repeat = true;
      // Construit l'image
      super(mTexture);
      // Désactive le smoothing
      smoothing = TextureSmoothing.NONE;
      // Attend l'ajout au stage pour resize
      addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    /** @inheritDoc */
    override public function dispose():void
    {
      super.dispose();
      // Suppression de la texture
      mTexture.dispose();
      // Suppression de l'écouteur
      removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
    }

    /** Ajout au stage, on prend 100% de l'écran */
    private function addedToStageHandler(pEvent:Event):void
    {
      removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
      // EnterFrame, déplacement de la texture
      addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
      // Resize
      width = stage.stageWidth;
      height = stage.stageHeight;
      mTextureScale.setTo(stage.stageWidth/mTexture.width, stage.stageHeight/mTexture.height);
    }

    /** Nouvelle frame */
    private function onEnterFrame(pEvent:EnterFrameEvent):void
    {
      mPassedTime += pEvent.passedTime;
      var texPos:Point = new Point(mPassedTime * mDisplacementSpeed * -1, mPassedTime * mDisplacementSpeed * -1);
      setTexCoords(0, texPos);texPos.offset(mTextureScale.x,0);
      setTexCoords(1,texPos);texPos.offset(-mTextureScale.x,mTextureScale.y);
      setTexCoords(2,texPos);texPos.offset(mTextureScale.x,0);
      setTexCoords(3,texPos);
    }
  }
}
