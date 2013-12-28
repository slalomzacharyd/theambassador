from django.conf.urls import patterns, url, include
from rest_framework import routers
from . import views

router = routers.DefaultRouter(trailing_slash=False)
router.register(r'auth-tokens', views.AuthTokenViewSet)
router.register(r'beverage-producers', views.BeverageProducerViewSet)
router.register(r'beverages', views.BeverageViewSet)
router.register(r'controllers', views.ControllerViewSet)
router.register(r'drinks', views.DrinkViewSet)
router.register(r'events', views.SystemEventViewSet)
router.register(r'flow-meters', views.FlowMeterViewSet)
router.register(r'kegs', views.KegViewSet)
router.register(r'pictures', views.PictureViewSet)
router.register(r'sessions', views.SessionViewSet)
router.register(r'taps', views.KegTapViewSet)
router.register(r'thermo-sensors', views.ThermoSensorViewSet)
router.register(r'users', views.UserViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browseable API.
urlpatterns = patterns('',
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
)
