package com.gamewars.components
{
  import flash.geom.Rectangle;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  
  import starling.display.DisplayObjectContainer;
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;
  import starling.utils.HAlign;
  import starling.utils.VAlign;
  
  public class GWButton extends DisplayObjectContainer
  {
    private static const MAX_DRAG_DIST:Number = 50;
    
    private var mUpState:Texture;
    private var mDownState:Texture;
    
    private var mContents:Sprite;
    private var mBackground:Image;
    private var mTextField:GwText;
    private var mTextBounds:Rectangle;
    
    private var mScaleWhenDown:Number;
    private var mAlphaWhenDisabled:Number;
    private var mEnabled:Boolean;
    private var mIsDown:Boolean;
    private var mUseHandCursor:Boolean;
    
    /** Bouton avec un GWTextField */
    public function GWButton(upState:Texture, text:String="", downState:Texture=null)
    {
      super();
      if (upState == null) throw new ArgumentError("Texture cannot be null");
      
      mUpState = upState;
      mDownState = downState ? downState : upState;
      mBackground = new Image(upState);
      mScaleWhenDown = downState ? 1.0 : 0.9;
      mAlphaWhenDisabled = 0.5;
      mEnabled = true;
      mIsDown = false;
      mUseHandCursor = true;
      mTextBounds = new Rectangle(0, 0, upState.width, upState.height);            
      
      mContents = new Sprite();
      mContents.addChild(mBackground);
      addChild(mContents);
      addEventListener(TouchEvent.TOUCH, onTouch);
      
      if (text.length != 0) this.text = text;
    }
    
    private function resetContents():void
    {
      mIsDown = false;
      mBackground.texture = mUpState;
      mContents.x = mContents.y = 0;
      mContents.scaleX = mContents.scaleY = 1.0;
    }
    
    private function createTextField():void
    {
      if (mTextField == null)
      {
        mTextField = new GwText(12);
        mTextField.vAlign = VAlign.CENTER;
        mTextField.hAlign = HAlign.CENTER;
        mTextField.touchable = false;
        mTextField.autoScale = true;
        mContents.addChild(mTextField);
      }
      
      mTextField.width  = mTextBounds.width;
      mTextField.height = mTextBounds.height;
      mTextField.x = mTextBounds.x;
      mTextField.y = mTextBounds.y;
    }
    
    private function onTouch(event:TouchEvent):void
    {
      Mouse.cursor = (mUseHandCursor && mEnabled && event.interactsWith(this)) ? 
        MouseCursor.BUTTON : MouseCursor.AUTO;
      
      var touch:Touch = event.getTouch(this);
      if (!mEnabled || touch == null) return;
      
      if (touch.phase == TouchPhase.BEGAN && !mIsDown)
      {
        mBackground.texture = mDownState;
        mContents.scaleX = mContents.scaleY = mScaleWhenDown;
        mContents.x = (1.0 - mScaleWhenDown) / 2.0 * mBackground.width;
        mContents.y = (1.0 - mScaleWhenDown) / 2.0 * mBackground.height;
        mIsDown = true;
      }
      else if (touch.phase == TouchPhase.MOVED && mIsDown)
      {
        // reset button when user dragged too far away after pushing
        var buttonRect:Rectangle = getBounds(stage);
        if (touch.globalX < buttonRect.x - MAX_DRAG_DIST ||
          touch.globalY < buttonRect.y - MAX_DRAG_DIST ||
          touch.globalX > buttonRect.x + buttonRect.width + MAX_DRAG_DIST ||
          touch.globalY > buttonRect.y + buttonRect.height + MAX_DRAG_DIST)
        {
          resetContents();
        }
      }
      else if (touch.phase == TouchPhase.ENDED && mIsDown)
      {
        resetContents();
        dispatchEventWith(Event.TRIGGERED, true);
      }
    }
    
    /** The scale factor of the button on touch. Per default, a button with a down state 
     * texture won't scale. */
    public function get scaleWhenDown():Number { return mScaleWhenDown; }
    public function set scaleWhenDown(value:Number):void { mScaleWhenDown = value; }
    
    /** The alpha value of the button when it is disabled. @default 0.5 */
    public function get alphaWhenDisabled():Number { return mAlphaWhenDisabled; }
    public function set alphaWhenDisabled(value:Number):void { mAlphaWhenDisabled = value; }
    
    /** Indicates if the button can be triggered. */
    public function get enabled():Boolean { return mEnabled; }
    public function set enabled(value:Boolean):void
    {
      if (mEnabled != value)
      {
        mEnabled = value;
        mContents.alpha = value ? 1.0 : mAlphaWhenDisabled;
        resetContents();
      }
    }
    
    /** The text that is displayed on the button. */
    public function get text():String { return mTextField ? mTextField.text : ""; }
    public function set text(value:String):void
    {
      createTextField();
      mTextField.text = value;
    }
    
    /** The name of the font displayed on the button. May be a system font or a registered 
     * bitmap font. */
    public function get fontName():String { return mTextField ? mTextField.fontName : "Verdana"; }
    public function set fontName(value:String):void
    {
      createTextField();
      mTextField.fontName = value;
    }
    
    /** The size of the font. */
    public function get fontSize():Number { return mTextField ? mTextField.fontSize : 12; }
    public function set fontSize(value:Number):void
    {
      createTextField();
      mTextField.fontSize = value;
    }
    
    /** The color of the font. */
    public function get fontColor():uint { return mTextField ? mTextField.color : 0x0; }
    public function set fontColor(value:uint):void
    {
      createTextField();
      mTextField.color = value;
    }
    
    /** Indicates if the font should be bold. */
    public function get fontBold():Boolean { return mTextField ? mTextField.bold : false; }
    public function set fontBold(value:Boolean):void
    {
      createTextField();
      mTextField.bold = value;
    }
    
    /** The texture that is displayed when the button is not being touched. */
    public function get upState():Texture { return mUpState; }
    public function set upState(value:Texture):void
    {
      if (mUpState != value)
      {
        mUpState = value;
        if (!mIsDown) mBackground.texture = value;
      }
    }
    
    /** The texture that is displayed while the button is touched. */
    public function get downState():Texture { return mDownState; }
    public function set downState(value:Texture):void
    {
      if (mDownState != value)
      {
        mDownState = value;
        if (mIsDown) mBackground.texture = value;
      }
    }
    
    /** The vertical alignment of the text on the button. */
    public function get textVAlign():String { return mTextField.vAlign; }
    public function set textVAlign(value:String):void
    {
      createTextField();
      mTextField.vAlign = value;
    }
    
    /** The horizontal alignment of the text on the button. */
    public function get textHAlign():String { return mTextField.hAlign; }
    public function set textHAlign(value:String):void
    {
      createTextField();
      mTextField.hAlign = value;
    }
    
    /** The bounds of the textfield on the button. Allows moving the text to a custom position. */
    public function get textBounds():Rectangle { return mTextBounds.clone(); }
    public function set textBounds(value:Rectangle):void
    {
      mTextBounds = value.clone();
      createTextField();
    }
    
    /** Indicates if the mouse cursor should transform into a hand while it's over the button. 
     *  @default true */
    public override function get useHandCursor():Boolean { return mUseHandCursor; }
    public override function set useHandCursor(value:Boolean):void { mUseHandCursor = value; }
  }
}