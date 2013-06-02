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
    private var mButtons:Vector.<Button> = new <Button>[];
    /** Callback de selection du menu */
    private var mCallback:Function;
    /** Background */
    private var mBackground:Quad;
    
    /** Constructeur */
    public function GwMenu(pMenuElements:Vector.<MenuElement>, pCallback:Function)
    {
      super();
      mMenuElements = pMenuElements;
      mCallback = pCallback;
      buildMenu();
    }
    
    /** Construction du menu */
    private function buildMenu() : void
    {
      // Arrière plan
      mBackground = new Quad(1, 1, 0x999999);
      addChild(mBackground);
      
      // Boutons de menu
      var xx:Number = 2;
      var yy:Number = 2;
      for each (var elt:MenuElement in mMenuElements)
      {
        var bt:Button = new Button(Resources.emptyTex(100, 60), elt.mText);
        bt.addEventListener(Event.TRIGGERED, menuElementClick);
        bt.x = xx;
        bt.y = yy;
        addChild(bt);
        mButtons.push(bt);
        yy += bt.height;
      }
      mBackground.width = width+4;
      mBackground.height = height+4;
    }
    
    /** Click sur un élément de menu */
    private function menuElementClick(pEvent:Event) : void
    {
      // Renvoie l'id de l'élément selectionné
      if (mCallback != null)
        mCallback(mMenuElements[mButtons.indexOf(pEvent.target as Button)].mId);
    }
  }
}