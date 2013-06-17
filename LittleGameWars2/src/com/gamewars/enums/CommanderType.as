package com.gamewars.enums
{
  import com.gamewars.utils.HashMap;
  import com.gamewars.utils.Resources;
  
  import starling.textures.Texture;

  /** Commandant d'unité. */
  public class CommanderType
  {
    /** Péfixe des textures des COs dans la sheet xml. */
    private static const _TEXTURE_PREFIX:String = "CO_";
    
    /** Nom du commander */
    protected var _name:String;
    
    public function get name():String
    {
      return _name;
    }
    
    /** Retourne la texture d'id pTextureId. */
    public function getTexture(pTextureId:String):Texture
    {
      return Resources.getGuiTex(_TEXTURE_PREFIX + _name.toUpperCase() + "_" + pTextureId);
    }
    
    /** Bonus continus du général. Clés de type String, valeurs de type int. */
    private var _bonus:HashMap;
    
    /** Retourne le bonus permanent pour une unité donnée. */
    public function getBonusByUnit(pUnitType:UnitType):int 
    {
      return getBonusById(pUnitType.mId);
    }
    
    /** Retourne le bonus permanent pour une unité d'id donné. */
    public function getBonusById(pUnitId:String):int
    {
      return _bonus.getValue(pUnitId);
    }
    
    /** Constructeur */
    public function CommanderType(pName:String)
    {
      _name = pName;
      
      _bonus = new HashMap();
      _initBonus();
    }
    
    /** Initialisation des bonus permanents. */
    protected function _initBonus():void
    {
      //A overrider si besoin. Pas de bonus par défaut.
      _bonus.put(UnitType.ALL_UNITS, 0);
    }
  }
}