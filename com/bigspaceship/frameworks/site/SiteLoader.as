class com.bigspaceship.frameworks.site.SiteLoader extends MovieClip
{
    var preloader_mc, _firstLoadFrame, _totalLoadFrames, _loader, _loader_events, _parent, dispatchEvent;
    static var __instance;
    function SiteLoader()
    {
        super();
        com.bigspaceship.events.EventDispatcher.initialize(this);
        preloader_mc = __instance = this;
        preloader_mc.onAnimateIn = com.bigspaceship.utils.Delegate.create(this, _onPreloaderIn);
        preloader_mc.onAnimateOut = com.bigspaceship.utils.Delegate.create(this, _onPreloaderOut);
        Stage.addListener(this);
        this.onResize();
    } // End of the function
    static function getInstance()
    {
        return (com.bigspaceship.frameworks.site.SiteLoader.__instance);
    } // End of the function
    function onResize()
    {
        preloader_mc.bg_clip.background._width = Stage.width;
        preloader_mc.bg_clip.background._height = Stage.height;
    } // End of the function
    function _onPreloaderIn()
    {
        com.bigspaceship.utils.Out.debug(this, "onPreloaderIn()");
        this.onResize();
        preloader_mc.progress_mc.onProgressBarComplete = com.bigspaceship.utils.Delegate.create(this, _onProgressBarComplete);
        preloader_mc.progress_mc.onEnterFrame = com.bigspaceship.utils.Delegate.create(this, _onProgressEnterFrame);
        _firstLoadFrame = Math.floor(preloader_mc.progress_mc._totalframes * com.bigspaceship.frameworks.site.SiteLoader.FIRSTLOADPERCENT);
        _totalLoadFrames = preloader_mc.progress_mc._totalframes - _firstLoadFrame - 2;
        var _loc2 = com.bigspaceship.utils.Environment.getFlashVar("assetPath") ? (com.bigspaceship.utils.Environment.getFlashVar("assetPath")) : ("");
        _loader = new MovieClipLoader();
        _loader_events = {};
        _loader_events.onLoadInit = com.bigspaceship.utils.Delegate.create(this, _onShellLoadInit);
        _loader.addListener(_loader_events);
        _loader.loadClip(_loc2 + "swf/d471main.swf", _parent.createEmptyMovieClip("shell_mc", 3));
        preloader_mc.onEnterFrame = com.bigspaceship.utils.Delegate.create(this, _onShellLoadProgress);
    } // End of the function
    function _onPreloaderOut()
    {
        preloader_mc._visible = false;
        this.dispatchEvent({target: this, type: com.bigspaceship.frameworks.site.SiteLoader.PRELOADER_OUT});
        __instance = null;
    } // End of the function
    function _onShellLoadProgress($mc, $bl, $bt)
    {
        var _loc2 = _loader.getProgress(_parent.shell_mc);
        if (_loc2.bytesTotal < 20 || !_loc2.bytesTotal)
        {
            preloader_mc.progress_mc.stop();
        }
        else
        {
            var _loc3 = _loc2.bytesLoaded / _loc2.bytesTotal;
            var _loc4 = Math.ceil(_firstLoadFrame * _loc3);
            _loc4 >= preloader_mc.progress_mc._currentframe ? (preloader_mc.progress_mc.play()) : (preloader_mc.progress_mc.stop());
        } // end else if
    } // End of the function
    function _onShellLoadInit()
    {
        preloader_mc.onEnterFrame = null;
        _loader.removeListener(_loader_events);
        _loader_events = null;
        preloader_mc.progress_mc.stop();
        _parent.shell_mc.gotoAndPlay("INIT");
    } // End of the function
    function updatePreloader($cTotal, $cLoaded, $cPercent, $sumPieces)
    {
        if ($cTotal < 20 || !$cTotal)
        {
            preloader_mc.progress_mc.stop();
        }
        else
        {
            var _loc5 = com.bigspaceship.frameworks.site.SiteLoader.FIRSTLOADPERCENT + $sumPieces;
            var _loc2 = $cLoaded / $cTotal * $cPercent;
            var _loc4 = Math.ceil((_loc5 + _loc2) * 100);
            _loc4 > preloader_mc.progress_mc._currentframe ? (preloader_mc.progress_mc.play()) : (preloader_mc.progress_mc.stop());
        } // end else if
    } // End of the function
    function _onProgressEnterFrame()
    {
        var _loc2 = Math.ceil(preloader_mc.progress_mc._currentframe / preloader_mc.progress_mc._totalframes * 100);
        preloader_mc.pct_mc.tf.txt.text = isNaN(_loc2) ? ("") : (_loc2.toString() + "%");
    } // End of the function
    function _onProgressBarComplete()
    {
        Stage.removeListener(this);
        preloader_mc.progress_mc.stop();
        preloader_mc.progress_mc.onEnterFrame = null;
        preloader_mc.progress_mc.pct_mc.tf.text = "";
        preloader_mc.gotoAndPlay("OUT");
    } // End of the function
    var _classname = "SiteLoader";
    static var PRELOADER_OUT = "preloader_out";
    static var FIRSTLOADPERCENT = 0;
    static var SECONDLOADPERCENT = 0;
    static var THIRDLOADPERCENT = 0;
} // End of Class
