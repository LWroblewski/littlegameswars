package com.gamewars.states.unitrelative
{
  import com.gamewars.components.GwMenu;
  import com.gamewars.components.menu.MenuElement;
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Unit;
  import com.gamewars.states.FreeState;
  
  public class UnitSelectedState extends UnitRelativeState
  {
    /** Menu affiché */
    private var mMenu:GwMenu;
    
    /** Constructeur */
    public function UnitSelectedState(pGameScreen:GameScreen, pUnit:Unit)
    {
      super(pGameScreen, pUnit);
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Affiche un menu d'actions
      var menuElements:Vector.<MenuElement> = new <MenuElement>[
        new MenuElement(0, 'Deplacement'),
        new MenuElement(1, 'Annuler')];
      if (getWorld().mPathFinding.computeTargetables(mUnit).length > 0)
      {
        menuElements.splice(1, 0, new MenuElement(2, 'Attaquer'));
      }
      mMenu = new GwMenu(menuElements, menuCallback);
      mMenu.x = 500;
      mMenu.y = 500;
      mGameScreen.addChild(mMenu);
    }
    
    /** @inheritDoc */
    override public function exitState():void
    {
      mGameScreen.removeChild(mMenu);
    }
    
    /** Click sur un élément de menu */
    private function menuCallback(pElementId:uint) : void
    {
      // Annulation
      switch (pElementId)
      {
        // Déplacement
        case 0:
          mGameScreen.setState(new MovementState(mGameScreen, mUnit));
          break;
        // Annuler
        case 1:
          mGameScreen.setState(new FreeState(mGameScreen));
          break;
        // Attaquer
        case 2:
          mGameScreen.setState(new AttackState(mGameScreen, mUnit));
          break;
      }
    }
  }
}