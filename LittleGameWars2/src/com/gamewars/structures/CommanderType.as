package com.gamewars.structures
{
  import com.gamewars.utils.Resources;
  
  import starling.textures.Texture;

  public class CommanderType
  {
    public static const CO_ANDY:CommanderType = new CommanderType('Susmonski', Resources.getGuiTex('Co_Andy'));
    
    /** Texture représentant le commandant */
    public var mTex:Texture;
    
    /** Constructeur */
    public function CommanderType(pName:String, pTex:Texture)
    {
      mTex = pTex;
    }
  }
}