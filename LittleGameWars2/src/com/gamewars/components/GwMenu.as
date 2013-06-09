package com.gamewars.components
{
  import com.gamewars.components.menu.MenuElement;
  import com.gamewars.utils.Resources;
  
  import starling.display.Button;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.events.Event;
  
  public class GwMenu extends GwBorderContainer
  {
    /** Elements affichés dans le menu */
    private var mMenuElements:Vector.<MenuElement>;
    /** Liste des boutons du menu */
    private var mButtons:Vector.<GwButton> = new <GwButton>[];
    /** Callback de selection du menu */
    private var mCallback:Function;
    
    /** Plus grande taille de bouton */
    private var mMaxButtonWidth:Number = 0;
    
    /** Constructeur */
    public function GwMenu(pMenuElements:Vector.<MenuElement>, pCallback:Function)
    {
      super();
      mMenuElements = pMenuElements;
      mCallback = pCallback;
      
      setBorderThickness(2);
      setPadding(5);
      setBorderColor(0);
      setBackgroundColor(0xffffff);
      
      buildMenu();
    }
    
    /** @inheritDoc */
    override protected function updateLayout() : void
    {
      var yy:Number = 0;
      for each (var bt:GwButton in mButtons)
      {
        bt.x = (mMaxButtonWidth - bt.width)/2;
        bt.y = yy;
        yy += bt.height;
      }
      super.updateLayout();
    }
    
    /** Construction du menu */
    private function buildMenu() : void
    {
      // Boutons de menu
      for each (var elt:MenuElement in mMenuElements)
      {
        var bt:GwButton = new GwButton(Resources.emptyTex(100, 40), elt.mText);
        bt.addEventListener(Event.TRIGGERED, menuElementClick);
        addChild(bt);
        mButtons.push(bt);
        mMaxButtonWidth = Math.max(bt.width, mMaxButtonWidth);
      }
      updateLayout();
    }
    
    /** Click sur un élément de menu */
    private function menuElementClick(pEvent:Event) : void
    {
      // Renvoie l'id de l'élément selectionné
      if (mCallback != null)
        mCallback(mMenuElements[mButtons.indexOf(pEvent.target as GwButton)].mId);
    }
  }
}