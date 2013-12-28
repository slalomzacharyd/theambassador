from pykeg.core import models
from rest_framework import serializers


class PictureSerializer(serializers.ModelSerializer):
    url = serializers.CharField(source='resized.url', read_only=True)
    original_url = serializers.CharField(source='image.url', read_only=True)
    resized_url = serializers.CharField(source='resized.url', read_only=True)
    thumbnail_url = serializers.CharField(source='thumbnail.url', read_only=True)
    class Meta:
        model = models.Picture
        exclude = ('image', )


class AuthTokenSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.AuthenticationToken


class ThermologSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Thermolog
        fields = ('time', 'temp')


class ThermoSensorSerializer(serializers.ModelSerializer):
    last_reading = ThermologSerializer(source='LastLog', read_only=True)
    class Meta:
        model = models.ThermoSensor


class BeverageProducerSerializer(serializers.ModelSerializer):
    picture = PictureSerializer(source='picture', read_only=True)
    class Meta:
        model = models.BeverageProducer


class BeverageSerializer(serializers.ModelSerializer):
    producer = BeverageProducerSerializer(source='producer')
    picture = PictureSerializer(source='picture', read_only=True)
    class Meta:
        model = models.Beverage


class ControllerSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Controller


class FlowMeterSerializer(serializers.ModelSerializer):
    meter_name = serializers.CharField(source='meter_name', read_only=True)
    controller = ControllerSerializer(source='controller', read_only=True)
    class Meta:
        model = models.FlowMeter


class KegSerializer(serializers.ModelSerializer):
    url = serializers.CharField(source='get_absolute_url', read_only=True)
    remaining_volume_ml = serializers.FloatField(source='remaining_volume_ml', read_only=True)
    beverage = BeverageSerializer(source='type')
    class Meta:
        model = models.Keg
        exclude = ('type', 'notes')


class KegTapSerializer(serializers.ModelSerializer):
    current_keg = KegSerializer(source='current_keg', read_only=True)
    temperature_sensor = ThermoSensorSerializer(source='temperature_sensor', read_only=True)
    class Meta:
        model = models.KegTap


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = (
            'username',
            'date_joined',
            'mugshot',
        )


class SessionSerializer(serializers.ModelSerializer):
    url = serializers.CharField(source='get_absolute_url', read_only=True)
    is_active = serializers.BooleanField(source='IsActiveNow', read_only=True)
    class Meta:
        model = models.DrinkingSession


class DrinkSerializer(serializers.ModelSerializer):
    url = serializers.CharField(source='get_absolute_url', read_only=True)
    user = UserSerializer(source='user', read_only=True)
    picture = PictureSerializer(source='picture', read_only=True)
    keg = KegSerializer(source='keg', read_only=True)
    session = SessionSerializer(source='session', read_only=True)
    class Meta:
        model = models.Drink
        depth = 1


class SystemEventSerializer(serializers.ModelSerializer):
    user = UserSerializer(source='user', read_only=True)
    drink = DrinkSerializer(source='drink', read_only=True)
    keg = KegSerializer(source='keg', read_only=True)
    session = SessionSerializer(source='session', read_only=True)
    class Meta:
        model = models.SystemEvent


