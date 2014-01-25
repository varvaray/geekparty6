
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.Sound;

@:sound("res/sounds/lose.mp3") class GameMusic extends flash.media.Sound {}

class SoundManager
{

        private static var _soundChannel:SoundChannel;


        public static function playSound(sound:Sound):void
        {
            if (_soundChannel)
            {
                _soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                _soundChannel.stop();
            }

            _soundChannel = sound.play();

            if (_soundChannel)
            {
                _soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
            }
        }

        private static function onSoundComplete(event:Event):void
        {
            _soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);

            _soundChannel = null;
        }
    }
}