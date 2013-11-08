object @request
attributes :id, :time_sent, :user_id, :accepted
child(:driver) { extends('api/v1/drivers/driver') }


