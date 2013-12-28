from pykeg.core import models
from rest_framework import viewsets
from . import serializers


class AuthTokenViewSet(viewsets.ModelViewSet):
    queryset = models.AuthenticationToken.objects.all()
    serializer_class = serializers.AuthTokenSerializer


class BeverageViewSet(viewsets.ModelViewSet):
    queryset = models.Beverage.objects.all()
    serializer_class = serializers.BeverageSerializer


class BeverageProducerViewSet(viewsets.ModelViewSet):
    queryset = models.BeverageProducer.objects.all()
    serializer_class = serializers.BeverageProducerSerializer


class ControllerViewSet(viewsets.ModelViewSet):
    queryset = models.Controller.objects.all()
    serializer_class = serializers.ControllerSerializer


class FlowMeterViewSet(viewsets.ModelViewSet):
    queryset = models.FlowMeter.objects.all()
    serializer_class = serializers.FlowMeterSerializer


class DrinkViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = models.Drink.objects.all()
    serializer_class = serializers.DrinkSerializer


class KegViewSet(viewsets.ModelViewSet):
    queryset = models.Keg.objects.all()
    serializer_class = serializers.KegSerializer


class KegTapViewSet(viewsets.ModelViewSet):
    queryset = models.KegTap.objects.all()
    serializer_class = serializers.KegTapSerializer


class PictureViewSet(viewsets.ModelViewSet):
    queryset = models.Picture.objects.all()
    serializer_class = serializers.PictureSerializer


class ThermoSensorViewSet(viewsets.ModelViewSet):
    queryset = models.ThermoSensor.objects.all()
    serializer_class = serializers.ThermoSensorSerializer


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = models.User.objects.all()
    serializer_class = serializers.UserSerializer


class SessionViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = models.DrinkingSession.objects.all()
    serializer_class = serializers.SessionSerializer


class SystemEventViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = models.SystemEvent.objects.all()
    serializer_class = serializers.SystemEventSerializer
