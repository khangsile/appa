object @request
attributes :id, :accepted
child(:trip) { extends('api/v1/trips/trip') }
child(:user) { extends('api/v1/users/user_base', locals: { hide_email: false }) }

