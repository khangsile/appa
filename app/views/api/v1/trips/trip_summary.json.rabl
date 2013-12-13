object @trip
extends('api/v1/trips/trip')
child(:users, object_root: false) { extends('api/v1/users/user_base', locals: { hide_email: true }) }