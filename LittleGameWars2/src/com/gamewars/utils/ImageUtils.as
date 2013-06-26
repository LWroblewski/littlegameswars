package com.gamewars.utils
{
  import flash.geom.Point;
  
  import starling.display.Image;
  
  /** Fonctions utilitaires de traitement des images. */
  public class ImageUtils
  {
    /** Répéte une image horizontalement et/ou verticalement. */
    public static function repeat(pImage:Image, pHorizontally:int = 1, pVertically:int = 1):void
    {
      pImage.setTexCoords(1,new Point(pHorizontally, 0));
      pImage.setTexCoords(2,new Point(0, pVertically));
      pImage.setTexCoords(3,new Point(pHorizontally, pVertically));
    }
    
    /** Répéte une image sur toute la longueur et/ou largeur de l'écran. */
    public static function repeatOnFullScreen(pImage:Image, pHorizontally:Boolean = true, pVertically:Boolean = true):void
    {
      if (pImage && pImage.stage)
      {
        var imgWidth:Number = pImage.width;
        var imgHeight:Number = pImage.height;
        
        if (pHorizontally) {
          pImage.width = pImage.stage.stageWidth; 
        }
        
        if (pVertically) {
          pImage.height = pImage.stage.stageHeight; 
        }
        
        repeat(pImage, pHorizontally ? int(pImage.width/imgWidth) : 1, pVertically ? int(pImage.height/imgHeight) : 1);
      }
    }
  }
}