package com.gamewars.components
{
  import com.gamewars.components.menu.MenuElement;
  import com.gamewars.utils.Resources;
  
  import starling.display.Button;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.events.Event;
  
  public class GwMenu extends Sprite
  {
    /** Elements affichés dans le menu */
    private var mMenuElements:Vector.<MenuElement>;
    /** Liste des boutons du menu */
    private var mButtons:Vector.<GWButton> = new <GWButton>[];
    /** Callback de selection du menu */
    private var mCallback:Function;
    /** Background */
    private var mBg:Quad;
    
    /** Constructeur */
    public function GwMenu(pMenuElements:Vector.<MenuElement>, pCallback:Function)
    {
      super();
      mMenuElements = pMenuElements;
      mCallback = pCallback;
      buildMenu();
    }
    
    /** Positionne les éléments */
    private function updateLayout() : void
    {
      var gap:Number = 0;
      var yy:Number = gap;
      mBg.width = mBg.height = 1;
      for each (var bt:GWButton in mButtons)
      {
        bt.x = (width - bt.width)/2 + gap;
        bt.y = yy;
        yy += bt.height;
      }
      mBg.width = width + gap;
      mBg.height = height;
    }
    
    /** Construction du menu */
    private function buildMenu() : void
    {
      // Arrière plan
      mBg = new Quad(1, 1, 0x999999);
      addChild(mBg);
      
      // Boutons de menu
      for each (var elt:MenuElement in mMenuElements)
      {
        var bt:GWButton = new GWButton(Resources.emptyTex(100, 60), elt.mText);
        bt.addEventListener(Event.TRIGGERED, menuElementClick);
        addChild(bt);
        mButtons.push(bt);
      }
      updateLayout();
    }
    
    /** Click sur un élément de menu */
    private function menuElementClick(pEvent:Event) : void
    {
      // Renvoie l'id de l'élément selectionné
      if (mCallback != null)
        mCallback(mMenuElements[mButtons.indexOf(pEvent.target as GWButton)].mId);
    }
  }
}