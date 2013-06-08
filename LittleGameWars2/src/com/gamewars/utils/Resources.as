package com.gamewars.utils
{
  import com.gamewars.enums.UnitType;
  
  import flash.utils.Dictionary;
  
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  /**
  * Classe de gestion des ressources du jeu
  */
  public class Resources
  {
    /** SpriteSheet */
    [Embed(source="resources/sheet.png")]
    private static var Sheet:Class;
    private static var sheetXml:XML = 
      <TextureAtlas>
       <SubTexture name="PLAIN" x="0" y="0" width="32" height="32"/>
       <SubTexture name="MOUNTAIN" x="64" y="0" width="32" height="32"/>
       <SubTexture name="FOREST" x="96" y="0" width="32" height="32"/>
      
       <SubTexture name="WATER_FULL_TL" x="0" y="64" width="16" height="16"/>
       <SubTexture name="WATER_SIDE_TL" x="32" y="64" width="16" height="16"/>
       <SubTexture name="WATER_SIDE2_TL" x="64" y="64" width="16" height="16"/>
       <SubTexture name="WATER_JOIN_TL" x="96" y="64" width="16" height="16"/>
       <SubTexture name="WATER_ISLE_TL" x="128" y="64" width="16" height="16"/>

       <SubTexture name="WATER_FULL_TR" x="16" y="64" width="16" height="16"/>
       <SubTexture name="WATER_SIDE_TR" x="48" y="64" width="16" height="16"/>
       <SubTexture name="WATER_SIDE2_TR" x="80" y="64" width="16" height="16"/>
       <SubTexture name="WATER_JOIN_TR" x="112" y="64" width="16" height="16"/>
       <SubTexture name="WATER_ISLE_TR" x="144" y="64" width="16" height="16"/>

       <SubTexture name="WATER_FULL_BL" x="0" y="80" width="16" height="16"/>
       <SubTexture name="WATER_SIDE_BL" x="32" y="80" width="16" height="16"/>
       <SubTexture name="WATER_SIDE2_BL" x="64" y="80" width="16" height="16"/>
       <SubTexture name="WATER_JOIN_BL" x="96" y="80" width="16" height="16"/>
       <SubTexture name="WATER_ISLE_BL" x="128" y="80" width="16" height="16"/>
      
       <SubTexture name="WATER_FULL_BR" x="16" y="80" width="16" height="16"/>
       <SubTexture name="WATER_SIDE_BR" x="48" y="80" width="16" height="16"/>
       <SubTexture name="WATER_SIDE2_BR" x="80" y="80" width="16" height="16"/>
       <SubTexture name="WATER_JOIN_BR" x="112" y="80" width="16" height="16"/>
       <SubTexture name="WATER_ISLE_BR" x="144" y="80" width="16" height="16"/>
      
       <SubTexture name="INFANTRY_0" x="0" y="32" width="32" height="32"/>
       <SubTexture name="INFANTRY_1" x="32" y="32" width="32" height="32"/>
       <SubTexture name="INFANTRY_2" x="64" y="32" width="32" height="32"/>
      
       <SubTexture name="STAR_ON" x="0" y="0" width="32" height="32"/>
       <SubTexture name="STAR_OFF" x="0" y="0" width="32" height="32"/>
      </TextureAtlas>;
    
    /** Bigunits */
    [Embed(source="resources/bigunits.png")]
    private static var BigUnits:Class;
    private static var bigunitsXml:XML = 
      <TextureAtlas>
        <SubTexture name="InfantryRun_0" x="0" y="0" width="32" height="32"/>
        <SubTexture name="InfantryRun_1" x="32" y="0" width="32" height="32"/>
        <SubTexture name="InfantryRun_2" x="64" y="0" width="32" height="32"/>
        <SubTexture name="InfantryRun_3" x="96" y="0" width="32" height="32"/>
        <SubTexture name="InfantryRun_4" x="128" y="0" width="32" height="32"/>
        <SubTexture name="InfantryRun_5" x="160" y="0" width="32" height="32"/>
        <SubTexture name="InfantryIdle" x="192" y="0" width="32" height="32"/>
        <SubTexture name="InfantryFire_0" x="192" y="0" width="32" height="32"/>
        <SubTexture name="InfantryFire_1" x="224" y="0" width="32" height="32"/> 
      </TextureAtlas>;
    
    /** SplashScreen */
    [Embed(source="resources/splash.png")]
    private static var Splash:Class;
    
    /** Gui */
    [Embed(source="resources/gui.png")]
    private static var Gui:Class;
    private static var guiXml:XML = 
      <TextureAtlas>
        <SubTexture name="btSkirmish" x="0" y="0" width="224" height="32"/>
        
        <SubTexture name="CursorSelect_0" x="0" y="32" width="32" height="32"/>
        <SubTexture name="CursorSelect_1" x="32" y="32" width="32" height="32"/>
        <SubTexture name="CursorSelect_2" x="64" y="32" width="32" height="32"/>
        <SubTexture name="CursorSelect_3" x="96" y="32" width="32" height="32"/>
        <SubTexture name="CursorTarget_0" x="128" y="32" width="32" height="32"/>
        <SubTexture name="CursorTarget_1" x="160" y="32" width="32" height="32"/>
        <SubTexture name="CursorTarget_2" x="192" y="32" width="32" height="32"/>
        <SubTexture name="CursorTarget_3" x="224" y="32" width="32" height="32"/>
    
        <SubTexture name="SelectionGrid_0" x="0" y="64" width="32" height="32"/>
        <SubTexture name="SelectionGrid_1" x="32" y="64" width="32" height="32"/>
        <SubTexture name="SelectionGrid_2" x="64" y="64" width="32" height="32"/>
        <SubTexture name="SelectionGrid_3" x="96" y="64" width="32" height="32"/>

        <SubTexture name="Arrow_0" x="0" y="96" width="32" height="32"/>
        <SubTexture name="Arrow_1" x="32" y="96" width="32" height="32"/>
        <SubTexture name="Arrow_2" x="64" y="96" width="32" height="32"/>
        
        <SubTexture name="Heart" x="0" y="240" width="16" height="16"/>
        <SubTexture name="Fuel" x="16" y="240" width="16" height="16"/>
        <SubTexture name="Ammo" x="32" y="240" width="16" height="16"/>
        <SubTexture name="Star_0" x="48" y="240" width="16" height="16"/>
        <SubTexture name="Star_1" x="64" y="240" width="16" height="16"/>

       <SubTexture name="Co_Andy" x="0" y="448" width="64" height="64"/>
      </TextureAtlas>;

    /** Backgrounds */
    [Embed(source="resources/backgrounds.png")]
    private static var Backgrounds:Class;
    private static var bgXml:XML = 
      <TextureAtlas>
        <SubTexture name="plain" x="0" y="0" width="128" height="168"/>
      </TextureAtlas>;

    private static var sSheetAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new Sheet()), sheetXml);
    private static var sGuiAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new Gui()), guiXml);
    private static var sBgAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new Backgrounds()), bgXml);
    private static var sBigUnitsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new BigUnits()), bigunitsXml);
    
    /** Retourne la texture de l'écran de splash */
    public static function getSplash() : Texture
    {
      var tex:Texture = Texture.fromBitmap(new Splash(), false, true);
      return tex;
    }

    public static var BT_SKARMISH:String = 'btSkirmish';
    /** Retourne la texture du bouton avec l'id pId*/
    public static function getButtonTex(pId:String) : Texture
    {
      return sGuiAtlas.getTexture(pId);
    }
    
    /** Retourne les textures pour l'unitée */
    public static function getUnitTextures(pUnitType:UnitType) : Vector.<Texture>
    {
      // TODO Retourner les textures selon l'unitée
      return sSheetAtlas.getTextures('INFANTRY');
    }
    
    /** Retourne les textures de tiles */
    public static function getStructureTextures(pStructureType:String) : Vector.<Texture>
    {
      return sSheetAtlas.getTextures(pStructureType);
    }
    
    /** Retourne les textures de tiles */
    public static function getTileTextures(pTileType:String) : Vector.<Texture>
    {
      return sSheetAtlas.getTextures(pTileType);
    }
    
    /** Retourne la première texture du nom passé en paramètres */
    public static function getSheetTexture(pName:String) : Texture
    {
      return getSheetTextures(pName)[0];
    }
    
    /** Retourne la première texture du nom passé en paramètres */
    public static function getSheetTextures(pName:String) : Vector.<Texture>
    {
      return sSheetAtlas.getTextures(pName);
    }
    
    /** Retourne une texture GUI */
    public static function getGuiTex(pName:String) : Texture
    {
      return sGuiAtlas.getTexture(pName);
    }
    
    /** Retourne une texture GUI */
    public static function getGuiTexs(pName:String) : Vector.<Texture>
    {
      return sGuiAtlas.getTextures(pName);
    }
    
    /** Retourne les textures de type de curseur */
    public static function getCursorTexs(pId:String) : Vector.<Texture>
    {
      return sGuiAtlas.getTextures(pId);
    }
    
    /** Retourne une texture vide */
    public static function emptyTex(pWidth:int, pHeight:int) : Texture
    {
      return Texture.empty(pWidth, pHeight);
    }
    
    /** Retourne la texture d'arrière plan */
    public static function getBackgroundTex(pId:String) : Texture
    {
      return sBgAtlas.getTexture(pId);
    }
    
    /** Retourne les textures de big units */
    public static function getBigUnitTexs(pId:String) : Vector.<Texture>
    {
      return sBigUnitsAtlas.getTextures(pId);
    }
  }
}