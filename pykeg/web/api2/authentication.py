from rest_framework import authentication
from rest_framework import exceptions

from pykeg.core import models

class KegbotAuthentication(authentication.BaseAuthentication):
    def authenticate(self, request):
        keystr = request.META.get('HTTP_X_KEGBOT_API_KEY')
        if not keystr:
            keystr = request.REQUEST.get('api_key')
        if not keystr:
            return None

        try:
            api_key = models.ApiKey.objects.get(key=keystr)
        except models.ApiKey.DoesNotExist:
            raise exceptions.AuthenticationFailed('API key does not exist')

        if not api_key.is_active():
            raise exceptions.AuthenticationFailed('Key and/or user is inactive')

        if not api_key.user or not api_key.user.is_active:
            raise exceptions.AuthenticationFailed('User is disabled or does not exist.')

        # TODO: remove me.
        if not api_key.user.is_staff and not api_key.user.is_superuser:
            raise exceptions.AuthenticationFailed('User is not staff/superuser')

        return (api_key.user, None)
