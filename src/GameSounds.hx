class GameSounds
{
	@:sound("res/PLAY.png") class BtnPlayPic extends flash.media.Sound {}
        public static var WIN_SOUND:Class;

        [Embed("/materials/sounds/lose.mp3")]
        public static var LOSE_SOUND:Class;

        [Embed("/materials/sounds/click.mp3")]
        public static const CLICK_SOUND:Class;
}