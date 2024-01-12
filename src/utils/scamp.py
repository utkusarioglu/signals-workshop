from scamp import settings


def set_default_scamp_settings():
    settings.PlaybackSettings(
        {
            **settings.PlaybackSettings.factory_defaults,
            "default_audio_driver": "pulseaudio",
        }
    )
