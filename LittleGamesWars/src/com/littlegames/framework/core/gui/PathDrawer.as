package com.littlegames.framework.core.gui
{
  import com.littlegames.framework.resources.Resources;
  
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.textures.TextureSmoothing;
  
  public class PathDrawer extends Sprite
  {
    private static const TEX_ARROW:String = "arrow";
    private static const TEX_PATH:String = "arrow_straight";
    private static const TEX_ANGLE:String = "arrow_turn";
    
    /** Liste des images servant à dessiner le chemin */
    private var _listImages:Vector.<Image> = new <Image>[];
    
    /** Constructeur */
    public function PathDrawer()
    {
      super();
    }
    
    /** Enlève le chemin affiché */
    public function clear() : void
    {
      var img:Image;
      // Rend invisible toutes les images
      for each (img in _listImages)
        img.visible = false;
    }
    
    /** Dessine le chemin */
    public function drawPath(pFromX:uint, pFromY:uint, pToX:uint, pToY:uint) : void
    {
      // Calcul le nombre d'images à afficher
      var imgCount:uint = Math.abs(pToX - pFromX) + Math.abs(pToY-pFromY);
      var img:Image;
      
      // Nettoyage
      clear();
      
      // Ajoute des images si necessaire
      while (_listImages.length < imgCount)
      {
        img = Resources.getImage(TEX_ARROW);
        img.smoothing = TextureSmoothing.NONE;
        // TODO TileSideLength
        img.pivotX = img.width / 2;
        img.pivotY = img.height / 2;
        img.width = img.height = 32;
        _listImages.push(img);
        addChild(img);
      }
      
      // Affiche les images
      var imgIdx:uint = 0;
      var xx:uint = pFromX;
      var yy:uint = pFromY;
      while (xx != pToX)
      {
        xx += pFromX > pToX ? -1 : 1;
        
        img = _listImages[imgIdx++];
        // Coin
        if (xx == pToX)
        {
          img.texture = Resources.getSingleTexture(TEX_ANGLE);
          // A gauche
          if (pFromX > pToX)
          {
            // En haut 
            if (pFromY > pToY)
              img.rotation = Math.PI/2;
            // En bas
            else
              img.rotation = Math.PI;
          }
          // A droite
          else if (pFromX < pToX)
          {
            // En haut
            if (pFromY > pToY)
              img.rotation = 0;
            // En bas
            else
              img.rotation = -Math.PI/2;
          }
          // Fin (Flèche)
          else
          {
            img.texture = Resources.getSingleTexture(TEX_ARROW);
          }
        }
        // Chemin
        else
        {
          img.texture = Resources.getSingleTexture(TEX_PATH);
          img.rotation = 0;
        }
        
        img.visible = true;
        // TODO TileSideLength + Layouter
        img.x = xx * 32 + img.width/2;
        img.y = yy * 32 + img.height/2;
      }
      // Avance d'un pas
      if (yy != pToY)
      {
        yy += yy > pToY ? -1:1;
      }
      while (yy != pToY)
      {
        img = _listImages[imgIdx++];
        img.texture = Resources.getSingleTexture(TEX_PATH);
        img.rotation = Math.PI/2;
        img.visible = true;
        // TODO TileSideLength + Layouter
        img.x = xx * 32 + img.width/2;
        img.y = yy * 32 + img.height/2;
        yy += yy > pToY ? -1:1;
      }
    }
    
  }//end class
}//end package